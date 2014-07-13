#!/bin/bash

function installDependencies()
{
    runAptGetUpdate

    installAptGetPackage 'build-essential'
    installAptGetPackage 'libssl-dev'

    if [[ ! -f "${pcreInstallFolder}/bin/pcregrep" ]]
    then
        "${appPath}/../../pcre/recipes/install.bash"
    fi
}

function install()
{
    # Clean Up

    rm -rf "${haproxyInstallFolder}"
    mkdir -p "${haproxyInstallFolder}"

    # Install

    local currentPath="$(pwd)"
    local tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${haproxyDownloadURL}" "${tempFolder}"
    cd "${tempFolder}" &&
    make "${haproxyConfig[@]}" &&
    make install PREFIX='' DESTDIR="${haproxyInstallFolder}"

    rm -rf "${tempFolder}"
    cd "${currentPath}"

    # Config Profile

    local profileConfigData=('__INSTALL_FOLDER__' "${haproxyInstallFolder}")

    createFileFromTemplate "${appPath}/../files/profile/haproxy.sh" '/etc/profile.d/haproxy.sh' "${profileConfigData[@]}"

    # Config Upstart

    local upstartConfigData=('__INSTALL_FOLDER__' "${haproxyInstallFolder}")

    createFileFromTemplate "${appPath}/../files/upstart/haproxy.conf" "/etc/init/${haproxyServiceName}.conf" "${upstartConfigData[@]}"

    # Start

    addSystemUser "${haproxyUID}" "${haproxyGID}"
    chown -R "${haproxyUID}":"${haproxyGID}" "${haproxyInstallFolder}"
    start "${haproxyServiceName}"

    # Display Version

    info "\n$("${haproxyInstallFolder}/sbin/haproxy" -vv 2>&1)"
}

function main()
{
    appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    checkRequireDistributor

    header 'INSTALLING HAPROXY'

    checkRequireRootUser
    checkRequirePort "${haproxyPort}"

    installDependencies
    install
    installCleanUp

    displayOpenPorts
}

main "${@}"