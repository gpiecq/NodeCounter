#!/bin/bash
VERSION=$(grep "## Version" NodeCounter.toc | sed 's/## Version: //')
ADDON_NAME="NodeCounter"
ZIPNAME="${ADDON_NAME}.zip"

echo "Packaging ${ADDON_NAME} v${VERSION}..."

rm -f "$ZIPNAME"

mkdir -p build/$ADDON_NAME/textures
mkdir -p build/$ADDON_NAME/textures/farming

cp NodeCounter.toc Core.lua GuideData.lua RoutesData.lua FarmingData.lua Tracking.lua \
   Counter.lua Routes.lua UI.lua README.md \
   build/$ADDON_NAME/

cp textures/*.tga build/$ADDON_NAME/textures/
cp textures/farming/*.tga build/$ADDON_NAME/textures/farming/

cd build
zip -r "../$ZIPNAME" $ADDON_NAME
cd ..
rm -rf build

echo "Created $ZIPNAME"
echo ""
echo "Upload to:"
echo "  - CurseForge: https://www.curseforge.com/wow/addons"
echo "  - Wago: https://addons.wago.io"
echo "  - WoWInterface: https://www.wowinterface.com"
