#! /bin/bash

# Variables
## Purge
### Google
app_purge_google=(
"com.google.android.youtube" \
"com.google.android.apps.maps" \
"com.google.android.apps.photos" \
"com.google.android.marvin.talkback" \
"com.google.android.setupwizard" \
"com.google.android.videos" \
"com.google.android.feedback" \
"com.google.android.syncadapters.calendar" \
"com.google.android.syncadapters.contacts" \
"com.google.android.apps.docs" \
"com.google.android.gm" \
"com.google.android.apps.tachyon" \
"com.google.android.music" \
"com.google.android.googlequicksearchbox" \
"com.google.android.apps.restore" \
"com.google.android.tts" \
"com.google.android.apps.magazines" \
"com.google.android.apps.books" \
"com.google.android.play.games" \
"com.google.android.talk" \
"com.google.android.apps.plus" \
"com.google.android.inputmethod.latin" \
"com.google.android.calendar" \
"com.google.android.contacts" \
"com.google.android.apps.messaging" \
"com.google.android.apps.genie.geniewidget" \
"com.google.android.keep" \
"com.google.android.calculator" \
"com.google.android.dialer" \
"com.google.android.deskclock" \
"com.google.android.apps.wallpaper" \
"com.google.android.projection.gearhead" \
"com.google.android.apps.wellbeing" \
"com.google.ar.lens" \
"com.android.hotwordenrollment.okgoogle" \
"com.android.hotwordenrollment.xgoogle" \
"com.google.android.documentsui" \
)
### Android
app_purge_android=(
"com.android.soundrecorder" \
"com.android.documentsui" \
"com.android.stk" \
"com.android.chrome" \
"com.android.browser" \
"com.android.calendar" \
"com.android.fileexplorer" \
"com.android.contacts" \
"com.android.mms" \
"com.android.deskclock" \
"com.android.providers.downloads.ui" \
)
### Launcher
app_purge_launcher=(
"com.wiko.launcher" \
"com.cooee.phenix" \
"com.miui.home" \
)
### Facebook
app_purge_Facebook=(
"com.facebook.katana" \
"com.facebook.system" \
"com.facebook.appmanager" \
"com.facebook.services" \
)
### APE
app_purge_ape=(
"com.ape.filemanager" \
"com.ape.cleanassist" \
"com.ape.calculator2" \
"com.ape.smartleftpage" \
"com.ape.weathergo" \
"com.ape.photos.editor" \
)
### Wiko
app_purge_wiko=(
"com.wiko.wiline" \
"com.wiko.wikosetupwizard" \
)
### Wiko
app_purge_miui=(
"com.miui.screenrecorder" \
"com.miui.yellowpage" \
"com.miui.cloudbackup" \
"com.mi.android.globalFileexplorer" \
"com.miui.bugreport" \
"com.miui.gallery" \
"com.xiaomi.mipicks" \
"com.mi.android.globalminusscreen" \
"com.xiaomi.calendar" \
"com.miui.compass" \
"com.mi.globalbrowser" \
"com.xiaomi.payment" \
"com.xiaomi.mi_connect_service" \
"com.micredit.in" \
"cn.wps.xiaomi.abroad.lite" \
"com.mipay.wallet.in"
"com.xiaomi.mirecycle" \
"com.miui.videoplayer" \
"com.miui.micloudsync" \
"com.miui.player" \
"com.miui.notes" \
"com.miui.calculator" \
"com.xiaomi.scanner" \
"com.miui.miservice" \
"com.xiaomi.midrop" \
"com.miui.backup" \
"com.miui.weather2" \
"com.miui.cloudservice" \
)
### Ironsource
app_purge_ironsource=(
"com.ironsource.appcloud.oobe.wiko" \
)
### Select
app_purge_select=(
"Google" "Google Apps" ON \
"Android" "Android Base Apps" ON \
"Launcher" "Launcher Apps" OFF \
"Facebook" "Facebook Apps" OFF \
"APE" "APE Apps" OFF  \
"Wiko" "Wiko Apps" OFF \
"Miui" "Miui Apps" OFF \
"Ironsource" "Ironsource Apps" OFF\
)

## Install
### App-Path
app_path="./apps/"
### Select
app_install_select=(
"Minimal" "Tastatur, Filemanager" ON \
"Basic" "Dialer, Contacts, Messages, Clock" ON \
"Tools" "Calendar, Calculator, Gallery, Notes" OFF \
"Nextcloud" "Nextcloud, Talk, Notes, Tasks, DAYx5" OFF \
"Launcher" "Trebuchet" OFF  \
"Browser" "Firefox" OFF  \
"Stores" "F-Droid" OFF \
"Aditional" "ThankYou App" OFF\
)
### Minimal
app_install_minimal=(
"tastatur" \
"filemanager" \
)
app_install_basic=(
"dialer" \
"contacts" \
"messages" \
"clock" \
)
app_install_tools=(
"calendar" \
"calculator" \
"gallery" \
"notes" \
)
app_install_nextcloud=(
"nextcloud" \
"nextcloud_talk" \
"nextcloud_notes" \
"opentasks" \
"davx5" \
)
app_install_browser=(
"firefox" \
)
app_install_stores=(
"fdroid" \
)
app_install_launcher=(
"trebuchet_8" \
)
app_install_aditional=(
"thankyou" \
)

# Functions
## Do Purge
function purge_apps() {
	apps=("$@")
	for app in "${apps[@]}"
	do
		echo "$app: $(adb shell pm uninstall --user 0 $app)"
	done
}
## Do Install
function install_apps() {
	apps=("$@")
	for app in "${apps[@]}"
	do
		echo "$app: $(adb install $app_path$app.apk)"
	done
}

# Purge Apps
## Purge Select
PURGE_APPS=$(
whiptail --title "App Installation" \
--checklist "Apps auswählen" 20 60 14 "${app_purge_select[@]}" \
3>&1 1>&2 2>&3)
if [ $? -gt 0 ]; then # user pressed <Cancel> button
        exit
fi
## Do Purge
for arg in $PURGE_APPS
do
	case $arg in
		"\"Google\"")
			purge_apps "${app_purge_google[@]}"
		;;
		"\"Android\"")
			purge_apps "${app_purge_android[@]}"
		;;
		"\"Launcher\"")
			purge_apps "${app_purge_launcher[@]}"
		;;
		"\"Facebook\"")
			purge_apps "${app_purge_Facebook[@]}"
		;;
		"\"APE\"")
			purge_apps "${app_purge_ape[@]}"
		;;
		"\"Wiko\"")
			purge_apps "${app_purge_wiko[@]}"
		;;
		"\"Miui\"")
			purge_apps "${app_purge_miui[@]}"
		;;
		"\"Ironsource\"")
			purge_apps "${app_purge_ironsource[@]}"
		;;
	esac
done

# Install Apps
## Install Select
INSTALL_APPS=$(
whiptail --title "App Installation" \
--checklist "Apps auswählen" 20 60 14 "${app_install_select[@]}" \
3>&1 1>&2 2>&3)
if [ $? -gt 0 ]; then # user pressed <Cancel> button
        exit
fi
for arg in $INSTALL_APPS
do
	case $arg in
		"\"Minimal\"")
			install_apps "${app_install_minimal[@]}"
		;;
		"\"Basic\"")
			install_apps "${app_install_basic[@]}"
		;;
		"\"Tools\"")
			install_apps "${app_install_tools[@]}"
		;;
		"\"Nextcloud\"")
			install_apps "${app_install_nextcloud[@]}"
		;;
		"\"Launcher\"")
			install_apps "${app_install_launcher[@]}"
		;;
		"\"Browser\"")
			install_apps "${app_install_browser[@]}"
		;;
		"\"Stores\"")
			install_apps "${app_install_stores[@]}"
		;;
		"\"Aditional\"")
			install_apps "${app_install_aditional[@]}"
		;;
	esac
done
