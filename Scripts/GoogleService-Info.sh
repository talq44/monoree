case "${CONFIGURATION}" in
  "debug" )
    cp -r "$SRCROOT/Resources/GoogleService-Info-Dev.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
  "release" )
    cp -r "$SRCROOT/Resources/GoogleService-Info-Prod.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;
  *)
    ;;
esac
