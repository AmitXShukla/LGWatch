'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "8fc8bd67a06d3956ba1847b7da986995",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"version.json": "84a57caa4b380aeb37d74c46e70c9c7e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/NOTICES": "6f4eb89e800ebbd1cb6eab8f4ef1ea82",
"assets/AssetManifest.bin": "c476614c36ecde5fe452e81e87971f4c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/ai_1.png": "09827be2cd4e4a1c3de96261e79d5cb3",
"assets/assets/ai_2.png": "b628a104cf376140dcbba632a5943b1a",
"assets/assets/images/hz_3.png": "2244ad0e9984f71cf7c8af3f93c27a1c",
"assets/assets/images/pic_7.png": "01042f21acdaac946c784b8002be283e",
"assets/assets/images/hz_6.png": "67104726db55993599f90e4e45f62648",
"assets/assets/images/hz_4.png": "9bdacc91b0c76542c2299194480c4988",
"assets/assets/images/p2p_3.png": "e3e24daa1281b91c45b31f858b37d000",
"assets/assets/images/p2p_2.png": "95789f9f07378c39f7158f0ad5c0e7d7",
"assets/assets/images/pic_6.png": "0ef080e8dc30108adc7f2f45fd0eb350",
"assets/assets/images/sensor_2.png": "703fa4c5f31eecd7df500ebb875581a8",
"assets/assets/images/pic_3.png": "6b539cbda157699bb6a6a60ed36418c3",
"assets/assets/images/hz_2.png": "030a813ccd28b3fd209dd30ebe127998",
"assets/assets/images/p2p_1.png": "39a0d0b16356623ef701f93c713d742a",
"assets/assets/images/pic_1.png": "f32067bc5bee669677821e5e37cff689",
"assets/assets/images/pic_4.png": "dc2b4184f317575aad74864be71c1629",
"assets/assets/images/sensors.jpg": "2cd8f6273f954e00bd8d5a3bb62fdbf8",
"assets/assets/images/p2p_4.png": "24ae1e56af7ac66acfcf6b8114d4adad",
"assets/assets/images/hz_5.png": "f56afcde88b31daec5b43dcf3ec32279",
"assets/assets/images/pic_8.png": "fdcfe9eea0a831bba83b1e26de2d667d",
"assets/assets/images/pic_5.png": "c141ae787016b63a7edad184d42f47a8",
"assets/assets/images/hz_8.png": "49f9415967bbea198e7aa6da94f197c3",
"assets/assets/images/hz_7.png": "ad3580ad778b0aade7625c46ece6ade4",
"assets/assets/images/hz_1.png": "8047996efed620ea39dcfb4faf7962e3",
"assets/assets/images/pic_2.png": "0ddc7cc3ef2d6d3b0107a580ecd980ad",
"assets/assets/process.png": "2dc6e7d00828536a635f6b3989f5f950",
"assets/fonts/MaterialIcons-Regular.otf": "ce59bb70295902880ea6976b7dc92467",
"assets/AssetManifest.json": "c8de6bc80fa714a275252bd10a0bce31",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"index.html": "0b985097ac4ca44ce410430117f05b9c",
"/": "0b985097ac4ca44ce410430117f05b9c",
"main.dart.js": "93cdb98cc979774d38d3ed29b3935115"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
