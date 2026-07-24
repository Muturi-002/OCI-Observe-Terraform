# Data source to get the image
data "oci_core_images" "instance_image" {
  compartment_id           = var.compartment_id
  operating_system         = var.vm_instance_OS
  operating_system_version = var.image_OS_version
  sort_order               = "ASC"
  sort_by                  = "DISPLAYNAME"

  /*
  Sorting the images in ascending order eases differentiation of the images. For image 'Canonical Ubuntu 24.04', the output should be as follows:
    available_images = {
      "Canonical-Ubuntu-24.04-2026.02.28-0" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa7mbdbl5e3ofgkccfq7di6tkvxlwfqq5c2bj7ghiiem63yhjqaxza"
      "Canonical-Ubuntu-24.04-2026.03.31-0" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa4vh3omm2j5ek736fdc4pk6kvxqwjbw23qkbcvfolbxio4klgmysq"
      "Canonical-Ubuntu-24.04-2026.04.30-1" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaaugp5l2jsq3q3utl4edhnxbfgb4zzr4rewj5h7tsehv6c7xgdhd5q"
      "Canonical-Ubuntu-24.04-aarch64-2026.02.28-0" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaan7f7yt7kfzskyov7ahm4zmjb4hv7m54ncnsslqilyy3wvpxlxsua"
      "Canonical-Ubuntu-24.04-aarch64-2026.03.31-0" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaawljtdvurh4lscvlrmlodq42z7oq3yz4wde2vexwjea4yceednaja"
      "Canonical-Ubuntu-24.04-aarch64-2026.04.30-1" = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa2ngirhwdkle6ttnioakq5m55rtjwgthtdpgoprszc3a6sv4nqw4q"
    }

    With this kind of order, picking a compartible image for the shape is more convenient.
  */
}
