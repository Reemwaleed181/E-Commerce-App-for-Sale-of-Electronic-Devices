import 'package:flutter/material.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Headphones data
  List<Map<String, dynamic>> getHeadphones() {
    return [
      {
        "image": "images2/Apple_AirPods_Max__Noise_Cancelling.png",
        "title": "Apple AirPods",
        "subtitle": "Description:",
        "subtitle2": "Noise Cancelling",
        "space":
            "Brand Name: Apple, Model Name: AirPods Max, Noise Control: Active Noise Cancellation, Connectivity Technology: Bluetooth, Color: White",
        "price": "650\$",
      },
      {
        "image": "images2/Apple_AirPods_Max_Wireless.png",
        "title": "Apple AirPods",
        "subtitle": "Description:",
        "subtitle2": "AirPods Max",
        "space":
            "Brand: Apple, Ear Placement: Over Ear, Form Factor: Over Ear, Noise Control: Active Noise Cancellation, Color: Sky Blue",
        "price": "550\$",
      },
      {
        "image": "images2/Beats_Studio_Pro.png",
        "title": "Beats",
        "subtitle": "Description:",
        "subtitle2": "Beats Pro",
        "space":
            "Brand: Beats, Ear Placement: Over Ear, Form Factor: Over Ear, Noise Control: Active Noise Cancellation, Color: Brown",
        "price": "400\$",
      },
      {
        "image": "images2/JBL_Tune_510BT__Wireless.png",
        "title": "JBL",
        "subtitle": "Description:",
        "subtitle2": "JBL Tune Wireless",
        "space":
            "Brand Name: JBL, Model Name: Bluetooth Headphone, Noise Control: None, Connectivity Technology: Wireless, Color: Black",
        "price": "450\$",
      },
    ];
  }

  // Laptops data
  List<Map<String, dynamic>> getLaptops() {
    return [
      {
        "image": "images2/Lenovo_IdeaPad.png",
        "title": "Lenovo",
        "subtitle": "Description:",
        "subtitle2": "Lenovo IdeaPad",
        "space":
            "Processor: Intel® Celeron® N4020 (2C/2T, 1.1/2.8GHz, 4MB) RAM: 8GB HDD: 256GB SSD Graphics: Intel® UHD Integrated Graphics",
        "price": "1350\$",
      },
      {
        "image": "images2/hp.png",
        "title": "HP",
        "subtitle": "Description:",
        "subtitle2": "HP Pad",
        "space":
            "Processor: Intel® Celeron® Processor N4500 4M Cache, up to 2.80 GHz RAM: 4 GB HDD: 512 GB SSD Graphics: Intel® Integrated Graphics",
        "price": "1450\$",
      },
      {
        "image": "images2/MacBook_Air_13.png",
        "title": "MacBook",
        "subtitle": "Description:",
        "subtitle2": "MacBook Air 13",
        "space":
            "Processor: M1 chip octa-core and 7-core RAM: 8GB Hard disk: 256GB SSD Color: Silver",
        "price": "1550\$",
      },
      {
        "image": "images2/Asus_Zenbook.png",
        "title": "Asus",
        "subtitle": "Description:",
        "subtitle2": "Asus ZenBook",
        "space":
            "Processor: AMD Ryzen™ 5 7520U Mobile Processor 2.8GHz (4-core/8-thread, 4MB cache, up to 4.3 GHz max boost) RAM: 8GB HDD: 512GB SSD Graphics: AMD Radeon™ Graphics",
        "price": "1050\$",
      },
    ];
  }

  // Mobile phones data
  List<Map<String, dynamic>> getMobiles() {
    return [
      {
        "image": "images2/phone2.png",
        "title": "iPhone",
        "subtitle": "Description:",
        "subtitle2": "iPhone 14 Pro Max",
        "space":
            "Model Name: iPhone 14 Pro Max, Operating System: iOS 16, RAM: 8 GB, Memory Storage: 128 GB, Color: Black",
        "price": "1650\$",
      },
      {
        "image": "images2/phone.png",
        "title": "iPhone",
        "subtitle": "Description:",
        "subtitle2": "iPhone 15",
        "space":
            "Model Name: iPhone 15, Operating System: iOS, RAM: 6 GB, Memory Storage: 128 GB, Color: Pink",
        "price": "1500\$",
      },
      {
        "image": "images2/samsung.png",
        "title": "Samsung",
        "subtitle": "Description:",
        "subtitle2": "Galaxy S23 Ultra",
        "space":
            "Model Name: Galaxy S23 Ultra, Operating System: Android 13, RAM: 12 GB, Memory Storage: 256 GB, Color: Phantom Black",
        "price": "1400\$",
      },
      {
        "image": "images2/google.png",
        "title": "Google",
        "subtitle": "Description:",
        "subtitle2": "Pixel 8 Pro",
        "space":
            "Model Name: Pixel 8 Pro, Operating System: Android 14, RAM: 12 GB, Memory Storage: 256 GB, Color: Obsidian",
        "price": "1300\$",
      },
    ];
  }

  // Watches data
  List<Map<String, dynamic>> getWatches() {
    return [
      {
        "image": "images2/watch.png",
        "title": "Smart Watch",
        "subtitle": "Description:",
        "subtitle2": "Apple Watch",
        "space":
            "Brand: Apple, Operating System: WatchOS, Memory Storage: 32 GB, Connectivity Technology: Wi-Fi, USB, Battery Cell Composition: Lithium Ion, GPS: Built-in GPS, Shape: Square",
        "price": "450\$",
      },
      {
        "image": "images2/samsung_watch.png",
        "title": "Samsung",
        "subtitle": "Description:",
        "subtitle2": "Galaxy Watch 6",
        "space":
            "Brand: Samsung, Operating System: Wear OS, Memory Storage: 16 GB, Connectivity Technology: Bluetooth, Wi-Fi, Battery: 300mAh, GPS: Built-in GPS, Shape: Round",
        "price": "350\$",
      },
      {
        "image": "images2/fitbit.png",
        "title": "Fitbit",
        "subtitle": "Description:",
        "subtitle2": "Sense 2",
        "space":
            "Brand: Fitbit, Operating System: Fitbit OS, Memory Storage: 4 GB, Connectivity Technology: Bluetooth, Wi-Fi, Battery: 6+ days, GPS: Built-in GPS, Shape: Square",
        "price": "300\$",
      },
    ];
  }

  // Gifts data
  List<Map<String, dynamic>> getGifts() {
    return [
      {
        "image": "images2/gift1.png",
        "title": "Gaming Bundle",
        "subtitle": "Description:",
        "subtitle2": "Gaming Accessories Set",
        "space":
            "Includes: Gaming Mouse, Keyboard, Headset, Mouse Pad, RGB Lighting, Compatible with PC/PS/Xbox",
        "price": "200\$",
      },
      {
        "image": "images2/gift2.png",
        "title": "Smart Home Kit",
        "subtitle": "Description:",
        "subtitle2": "Smart Home Starter Pack",
        "space":
            "Includes: Smart Bulb, Smart Plug, Smart Speaker, Compatible with Alexa and Google Home",
        "price": "150\$",
      },
      {
        "image": "images2/gift3.png",
        "title": "Photo Frame",
        "subtitle": "Description:",
        "subtitle2": "Digital Photo Frame",
        "space":
            "10-inch HD Display, Wi-Fi Enabled, Cloud Storage, Auto-Rotate Photos, Multiple Display Modes",
        "price": "100\$",
      },
    ];
  }

  // Featured products data
  List<Map<String, dynamic>> getFeaturedProducts() {
    return [
      ...getHeadphones().take(2),
      ...getLaptops().take(2),
      ...getMobiles().take(2),
    ];
  }
}
