FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/${DISTRO_NAME}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
PR .= ".2"

PACKAGE_ARCH := "${MACHINE_ARCH}"

SRC_URI += " \
    file://67_init_hddown.dpatch \
    file://92_sata-hddown.dpatch \
"

do_install:append() {
    rm ${D}${sysconfdir}/rc*.d/*bootlogd

    # spawn a logon prompt on serial console
    sed -i -e \
        's/^SULOGIN=.*/SULOGIN=${SERIAL_DEBUG}/' \
        ${D}${sysconfdir}/default/rcS
    # verbose output on serial console
    sed -i -e \
        's/^VERBOSE=.*/VERBOSE=${@bb.utils.contains("SERIAL_DEBUG","yes","very","no", d)}/' \
        ${D}${sysconfdir}/default/rcS
}
