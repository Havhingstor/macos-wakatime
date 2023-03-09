source = ["./WakaTime.app"]
bundle_id = "macos-wakatime.WakaTime"

apple_id {
  username = "alan@wakatime.com"
  password = "@env:AC_PASSWORD"
}

sign {
  application_identity = "Developer ID Application: WAKATIME, LLC"
}

zip {
  output_path = "WakaTime.zip"
}
