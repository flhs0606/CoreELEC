# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Team CoreELEC (https://coreelec.org)

PKG_NAME="libdovi"
PKG_SITE="https://github.com/quietvoid/dovi_tool"
PKG_DEPENDS_TARGET="toolchain"
BUILD_FROM_SRC="${BUILD_FROM_SRC:-no}"
if [ "${BUILD_FROM_SRC}" = "yes" ]; then
  PKG_VERSION="d1abe0e27ff2c7ab3339614d06db9f8a058af6b2"
  PKG_SHA256="0ebd39fa1ff4c5e74df6fab2695876aa145365beb4be93b153144358a282dbe9"
  PKG_URL="https://github.com/quietvoid/dovi_tool/archive/${PKG_VERSION}.tar.gz"
  PKG_DEPENDS_TARGET+=" cargo-c:host"
else
  PKG_VERSION="3.4.0"
  case "${TARGET_ARCH}" in
    "arm")
      PKG_SHA256="f16d6b0d21e8db69e41582f7095c0cc844b914e051113b3cefc2100fd999219b"
      ;;
    "aarch64")
      PKG_SHA256="e6e0bb82198a58a58cd38bbb2a6d286ff9d024ad35f490ff4b127ea415521457"
      ;;
  esac
  PKG_SOURCE_NAME="${PKG_NAME}-${ARCH}-${PKG_VERSION}.tar.xz"
  PKG_URL="https://sources.coreelec.org/${PKG_SOURCE_NAME}"
  PKG_SOURCE_DIR="${PKG_NAME}-${ARCH}-${PKG_VERSION}"
fi
PKG_LICENSE="MIT"
PKG_LONGDESC="dovi_tool is a CLI tool combining multiple utilities for working with Dolby Vision."
PKG_TOOLCHAIN="manual"

if [ "${BUILD_FROM_SRC}" = "yes" ]; then
pre_make_target() {
  CARGO_BASE_OPTS="--manifest-path ${PKG_BUILD}/dolby_vision/Cargo.toml \
                   --target ${TARGET_NAME}"
  CARGO_BUILD_OPTS="--library-type staticlib --library-type cdylib \
                    --profile release \
                    --prefix /usr \
                    ${CARGO_BASE_OPTS}"
}

make_target() {
  cargo fetch ${CARGO_BASE_OPTS}
  cargo cbuild ${CARGO_BUILD_OPTS}
}

makeinstall_target() {
  cargo cinstall ${CARGO_BUILD_OPTS} --destdir ${SYSROOT_PREFIX}
  cargo cinstall ${CARGO_BUILD_OPTS} --destdir ${INSTALL}
}
else
make_target() {
  cp -PR * ${SYSROOT_PREFIX}
}

makeinstall_target() {
  : #
}
fi
