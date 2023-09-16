# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "google-maps", to: "https://ga.jspm.io/npm:google-maps@4.3.3/lib/cjs/index.js", preload: true
pin "@googlemaps/js-api-loader", to: "https://ga.jspm.io/npm:@googlemaps/js-api-loader@1.16.2/dist/index.esm.js", preload: true
pin "underscore", to: "https://ga.jspm.io/npm:underscore@1.13.6/modules/index-all.js", preload: true
pin "map_new", to: "map_new.js"
pin "map_show", to: "map_show.js"
pin "geolocation", to: "geolocation.js"
pin "sweetalert2", to: "https://ga.jspm.io/npm:sweetalert2@11.7.28/dist/sweetalert2.all.js", preload: true
