#!/bin/sh
set -eu

# Paths
## Config path
BASH_SETUP_CONFIG_DIR="${HOME}/.config/bash"
## Share
BASH_SETUP_LOCAL_DIR="${HOME}/.local/opt/bash/share"

# Versioning
## Target version
BASH_SETUP_VERISON=1.3
## Current version(loaded dynamically)
BASH_SETUP_VERSION_CURR=
BASH_SETUP_VERSION_FILE="${BASH_SETUP_LOCAL_DIR}/version"

# Backup mechanism
## Backup path
BASH_SETUP_BACKUP="${HOME}/.local/opt/bash/bkupbash"
## Backup currdir
BASH_SETUP_BACKUP_CURR_DIR=${BASH_SETUP_BACKUP}/$(date "+%F-%T")
## Targets
### Root
BASH_SETUP_BACKUP_ROOT=${BASH_SETUP_BACKUP_CURR_DIR}/.bashrc
### local
BASH_SETUP_BACKUP_LOCAL=${BASH_SETUP_BACKUP_CURR_DIR}/local
### config folder
BASH_SETUP_BACKUP_CONFIG=${BASH_SETUP_BACKUP_CURR_DIR}/config

# Files (Addded with `gzip -c < file|base64 -w0`)
## ~/.bashrc
BASH_SETUP_FILE_ROOT="H4sIAEok1WQAAwtwDPGId3IM9oh39vdz83S3VVLx8Pd11ddLzs9Ly0zXT0oszlDi4kJSEe/m6eMaDFSnkZaZl6KgpFIdgGZGrZKCbkllQapCmkJNcX5RiSbQgLT8IoXMktRchcw8BZVqDONqFbhS8rkUFIrzS4uSUxVUQEqBInmpXEAAAGZylTWkAAAA"
## ~/.config/bash/10-ubuntudefaults
BASH_SETUP_FILE_10_UBUNTUDEFAULTS="H4sIAMtR1WQAA5VUXW/bOBB816/Yc4PWDmwr7WMDPxU+xICbAOfeyx2KgpJWFhGa1JFUbKdof/vNUrLroMUBFziG+bE7s7OzfEXf83mhQuPL98QHLrvIFRVHkr3x2wnVzpN1dmbcVlsKDRsT5tkrCsyUd8HnoVGe88qVuYTkfFC71nDIQ1Q+du2s1ljRGMGxYWpV+ai2nNLPEDRBKoE4hWVYr2ogRvKdtdpuSdvIXpVRP7E5Tqly9k3ENyl7jA0uZKUKTFczXMwIf9f6ekK3t+k3VhPyHDtvscNBlQLQp2g7pOlao0sVmYy2oAkm/Y/EXtD3OjYUQJtpKKHRITp/FBE2zC+E2jnP5NqonQ3Z3Wrz6cPD/ac/HtYLvbU4KlxsBF+1LduKorvMRyLUqTz3xH7vNXjpmIUGKWkW0s0+NhtkCxwTy1MOw3YrfMFL4Derv5bQqUqL31frZdpAHQPp7LS/GF19vXv4uPyWz40rlcmflM+NLvqeyteXAWKUnRIv3t7c3GSXmRfvZAfUyobLx1TcXtvK7SnoZyZVo5HEqmyodLud8ML/lDT6zSWHoPxxiuiuraQjEv6kTCdtqWm9ul9uUi0fHtZ/frzfzH/okuCAJCiDgSDMdDBcBKql0fX1iLoAc6N8JduNVTuG8VqFQGfBCUY7RFA2Bkl2KoKoMoZ6Bwv0M3tHpz5X2nMJSfRwGLriYgv2OPPbGleIobKU9hFmQ7F9khp3bWWO5zlLFLQVcybcaWqmBLS6ZenZ3zQ79KNXaJufTugzvX5NDMFodDXe3C3X60W6EJpz9GSUpcmN0NVrVRjYq2IbdX0UE4lcZeMdZu/oOto7/yhijU+qJTm926Gogo3bTzJ0Dmyegfi14kIr+6WPfz/7NuoJ4dhTzrHMX1ygz7eSrh/YFyeLqzHm8Rchk6zWQp9tIg4iW6/gIlnATng8ZOyoZoVplxdHauinyTKnaetDkQPvRki+0/ENmmc8q+o4HKdSE7zYfngbU4PTJnClL6Kj6zxc+9PdyVx0+Y2G9rt/qHVBH84F96LVl69neg1/FNEP3EVRl2rN/0cgAtic8U48/yPzL67gCMLj8y/5QMLCKwYAAA=="
## ~/.config/bash/11-paths
BASH_SETUP_FILE_11_PATHS="H4sIALZU1WQAAwtwDPGwVVIJAFJWKh7+vq76ejn5yYk5+kmZefrp+SBKiSsAjyIlLi4AbT3F70QAAAA="
## ~/.config/bash/13-alias
BASH_SETUP_FILE_13_ALIAS="H4sIAJoh1WQAA11Ry27bMBC86ysGimE1aSU6x8YwiiBAfqDoobCdYCOuLCIUKXAppAKEfnspKekhJy5nZ2f2cQXxHaPzgWEFZA0JS7a8sPZQJLAk+1h8QLRC9/+B9f+QGNkV7rUGOeRkOcR8lUPjA6x3F4TBOZPe2ncdOS0V8EuSr3nl1MZdqgfEMve43e2xaLy7LPGhcD6aZiyFnUZZDuHCrh4P1r+hNMg3X47Y/MABO5yx3YLr1iNy6Iwji2laAQ7Bh+t8prdGog/jFMlYlO52Ek66jOJUFKKeTnJz3JXfz6evKVJqL+q4307n9Fna2Sg1E6/zdfKlT82NcSYa76RK4G8/oKMRb+Qiokc/xDSKxeiHANJ6ZcK4lCMI9xQoMhpj160kib+qeiFpn98v8y2RJTJp+GZRSOuMLXdoOV1Qm8B1tOPs/ZMZapCgpKXASvtazULlHPAf6nrLs/NcjY8Eeqpf6cJVlpkGR5TNZ3+c93OFy9KpUH3OZo3J/gH0a3VIUgIAAA=="
## ~/.config/bash/15-alias
BASH_SETUP_FILE_15_COLORS="H4sIABkd1WQAA5VUWW/aQBB+jn/FyKAAKYQjh1ojV5FQVEVKlSqp1IeA0GKPYytml+7BodL+9s7ukgRCWrXIMuuZb2a+ubYCCjUwyBhPVjCTYjrTUOeCtxJRCtkEw0tUChYIj1ws7H+4YFyH4PSNIGGKRNWvl7efQyh4APRbapRT72B91OqdnXusNxn7IPEKVb8foGJJEFQoTCKmU+QaMiGJj4NiumHUhCIDnSNYxwVnJeRMOUHCZmxSlIVe9UEbyTElZyLLYLKCFDNmSg1aABca0kJpyRLt7IxCGblTJhKjiDkFffa+KHgqFuRJ5cKUKUwQBHdoYfTMaIoAli/jqWo65xu1pxtUKIkEx6/zDQJK4x5anAq2jwhh1LdOfA09cglto2R7UvC2izuCw0NwJ2oby6ALHw/bKc7b3JTlxvqgAt+QCjRHX0VQZjYTUveBKWWmCIWuKUt/VhbUSUpW53CZTFnr9L01rl/d3bSvLget89Peh8Yx1K9Z8mgzVibJn5xBoQCXWuIUyxVIJrEJVA2HsU6og3YwFq58GklDXXiyJe4Z2RBbSZQZ98kcN4KDvYrZUmCp8JXKybMioMfXNKzuljIGst4p6Je7blyr/khxQlmPk1wKoaN39eqOoPFzeD/snJzcd7r9k950OBqai2H+JOuQINoCnFrAYls7rEItcHz/J6SNEZEja0wZGW53cjsf2J8WuzRXdimoEfRQEd3WuXV2m1LoEm3R7aRf5ELpKC3k3ro6o6O1XM71UeOZdEg54ajT/1fuQOTZcFQl29A5oc3euNvaceRsUr4aSjtXpXKjw0olgKUpjS5PV/RZEFcV7C0CpeFc7LZXo9LQkvCrffwCoGXBOe1zWK2/CFuTHVAjhPX6TVjD5+KIEMm4RkRb/lqLmdGi5tQVryfDuEavPyPmDjLfx2xFeZA4i2v2/YYfD8k8JvsrCD0I3wDZlak836+fBgNYMMkL/uC7gFJS9gEuXXdIPR7cXN/c3pEzq4nt3HejjYn7OovoAkR3PI8Sugm0O/ei0t6sdI6+Gw+oBb8BXPtjkG8GAAA="
## ~/.XdefaultsA
BASH_SETUP_FILE_XDEFAULTS="H4sIAGSb72QAA02RQU+EMBCF7/yKIVzUxLXAFgqJJz150E003qd02N2IsCmQdf31tmw6eGvfvG/6ZhrH8GGxH09oqW8ucCPu09s6uttgdzpgDWKjZBTFMbzTBAiGWpy7Cdqhd9feXA/j8ZcAR9DUDWcPe7WG3c82L+H57f3hEyxt4GX3mguovfsxLVxXGE/UHLFbCEt7O8y9qQEgMdpUxjhdY/P1TxeFkKJ0ejPbcbBPQzfYevW7lrpzhDf4kvAQLKDDhAy6Yr0UFWLlQUsmlFMuU6tlq4JerVhRtUge21uiPhgyNjSVzqnkhiFIUqRYVakHL9S5bQVHzqQxRhIyGbIkmOqy2F5HnCnUt8wVmaRCM5cxp7Qulxe/cU/9xK0lo6pUuWoZDVkSyl2S5aOaC/KQBXM6w1avQ26Zy1Do1nPnw3HirOW61pwy4t9IJYMKG5VHf4mg1cKVAgAA"


LogTrace()
{
    DATE="$(date)"
    MSG="${1}"

    echo "${DATE} - TRACE - ${MSG}"
}

LogError()
{
    DATE="$(date)"
    MSG="${1}"

    echo "${DATE} - ERROR- ${MSG}"
}

OverrideFileInline()
{
    # Paramaters
    OVERRIDE_FILE_INLINE_OPT_CONTENT="${1}"
    OVERRIDE_FILE_INLINE_OPT_TARGET="${2}"
    set +u
    OVERRIDE_FILE_INLINE_OPT_DISABLE_GZIP="${3}"
    set -u

    OVERRIDE_FILE_INLINE_IS_GZIP=yes
    OVERRIDE_FILE_INLINE_BASEDIR=$(dirname "${OVERRIDE_FILE_INLINE_OPT_TARGET}")

    if [ -z "${OVERRIDE_FILE_INLINE_OPT_CONTENT}" ]
    then
        LogError "No content proviced"
        exit 1
    fi

    if [ -z "${OVERRIDE_FILE_INLINE_OPT_TARGET}" ]
    then
        LogError "No Target path provided"
        exit 1
    fi

    if [ -n "${OVERRIDE_FILE_INLINE_OPT_DISABLE_GZIP}" ]
    then
        OVERRIDE_FILE_INLINE_IS_GZIP=
    fi


    
    LogTrace "Ensuring folder ${OVERRIDE_FILE_INLINE_BASEDIR}"
    mkdir -p "${OVERRIDE_FILE_INLINE_BASEDIR}"

    LogTrace "Putting in ${OVERRIDE_FILE_INLINE_OPT_TARGET}: "
    if [ -n "${OVERRIDE_FILE_INLINE_IS_GZIP}" ]
    then
        LogTrace "$(echo "${OVERRIDE_FILE_INLINE_OPT_CONTENT}"|base64 -d|gunzip -c)"
        (echo "${OVERRIDE_FILE_INLINE_OPT_CONTENT}"|base64 -d|gunzip -c) > "${OVERRIDE_FILE_INLINE_OPT_TARGET}"
    else
        LogTrace "$(echo "${OVERRIDE_FILE_INLINE_OPT_CONTENT}"|base64 -d)"
        (echo "${OVERRIDE_FILE_INLINE_OPT_CONTENT}"|base64 -d) > "${OVERRIDE_FILE_INLINE_OPT_TARGET}"
    fi
}


LogTrace "Creating directories: ${PATH_LOCAL_BIN}, ${BASH_SETUP_CONFIG_DIR}, ${BASH_SETUP_LOCAL_DIR}, ${BASH_SETUP_BACKUP}"
mkdir -p "${PATH_LOCAL_BIN}" "${BASH_SETUP_CONFIG_DIR}"  "${BASH_SETUP_LOCAL_DIR}" "${BASH_SETUP_BACKUP}"

if [ -e "${BASH_SETUP_VERSION_FILE}" ]
then
    BASH_SETUP_VERSION_CURR=$(cat "${BASH_SETUP_VERSION_FILE}")
    LogTrace "Found previous version install ${BASH_SETUP_VERSION_CURR}"
fi

if [ "${BASH_SETUP_VERSION_CURR}" != "${BASH_SETUP_VERISON}" ]
then
    LogTrace "Installing new verison- Current version: ${BASH_SETUP_VERSION_CURR} is not matching target version ${BASH_SETUP_VERISON}"

    LogTrace "Creting backup folders: ${BASH_SETUP_BACKUP_CURR_DIR}, ${BASH_SETUP_BACKUP_LOCAL}, ${BASH_SETUP_BACKUP_CONFIG}"
    mkdir -p "${BASH_SETUP_BACKUP_CURR_DIR}" "${BASH_SETUP_BACKUP_LOCAL}" "${BASH_SETUP_BACKUP_CONFIG}"

    LogTrace "Backing up old version"
    cp  "${HOME}/.bashrc" "${BASH_SETUP_BACKUP_ROOT}"
    cp  -r "${BASH_SETUP_LOCAL_DIR}" "${BASH_SETUP_BACKUP_LOCAL}"
    cp  -r "${BASH_SETUP_CONFIG_DIR}" "${BASH_SETUP_BACKUP_CONFIG}"

    LogTrace "Creating new config folder"
    mkdir -p "${BASH_SETUP_CONFIG_DIR}"

    LogTrace "Creating file ${BASH_SETUP_CONFIG_DIR}"

    OverrideFileInline "${BASH_SETUP_FILE_10_UBUNTUDEFAULTS}" "${BASH_SETUP_CONFIG_DIR}/10-ubuntudefaults"
    OverrideFileInline "${BASH_SETUP_FILE_11_PATHS}" "${BASH_SETUP_CONFIG_DIR}/11-paths"
    OverrideFileInline "${BASH_SETUP_FILE_13_ALIAS}" "${BASH_SETUP_CONFIG_DIR}/13-alias"
    OverrideFileInline "${BASH_SETUP_FILE_15_COLORS}" "${BASH_SETUP_CONFIG_DIR}/15-colors"
    OverrideFileInline "${BASH_SETUP_FILE_ROOT}" "${HOME}/.bashrc"
    OverrideFileInline "${BASH_SETUP_FILE_XDEFAULTS}" "${HOME}/.Xdefaults"

    LogTrace "Overriding version file with ${BASH_SETUP_VERISON}"
    echo "${BASH_SETUP_VERISON}" > "${BASH_SETUP_VERSION_FILE}"
else
    LogTrace "Current version: ${BASH_SETUP_VERSION_CURR} is matching target version ${BASH_SETUP_VERISON}"
fi

