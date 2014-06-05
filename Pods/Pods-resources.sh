#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/056-PlusCircle.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/056-PlusCircle@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/191-ArrowHead-left.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/191-ArrowHead-left@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/191-ArrowHead-right.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/191-ArrowHead-right@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/248-QuestionCircleAlt.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/248-QuestionCircleAlt@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/248-QuestionCircleAlt_black.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/248-QuestionCircleAlt_black@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/271-ThreeColumn.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/271-ThreeColumn@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/277-MultiplyCircle-black.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/277-MultiplyCircle-black@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/277-MultiplyCircle-white.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/277-MultiplyCircle-white@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/310-RemoveButton.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/310-RemoveButton@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net/License.rtf"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/iconshock.com/internalWebBrowserActivity@2x~ipad.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/iconshock.com/internalWebBrowserActivity@2x~iphone.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/iconshock.com/internalWebBrowserActivity~ipad.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/iconshock.com/internalWebBrowserActivity~iphone.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/action.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/back.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/forward.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/refresh.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPad/stop.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/back.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/back@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/forward.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle/iPhone/forward@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAAboutCustomView.xib"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAEntityConfig.plist"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAFormSectionHeaderView.xib"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAHelpPopTipCustomView.xib"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAHelpPopTipView.css"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFAHtmlTemplate.txt"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFASliderView.xib"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/IFATableSectionHeaderView.xib"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/textViewBorder.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/textViewBorder@2x.png"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/billybarker.net"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/iconshock.com"
install_resource "../../../GustyLib/GustyLib_development/GustyLib/GustyLib/Core/resources/3rd party/SVWebViewController/SVWebViewController.bundle"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ `xcrun --find actool` ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in 
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;  
  esac 
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
