# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "cocoon-js-vanilla", to: "https://unpkg.com/@oddcamp/cocoon-vanilla-js"
pin "google-maps", to: "https://ga.jspm.io/npm:google-maps@4.3.3/lib/cjs/index.js"
pin "@googlemaps/js-api-loader", to: "https://ga.jspm.io/npm:@googlemaps/js-api-loader@1.16.2/dist/index.esm.js", preload: true
# pin "map"
pin "underscore", to: "https://ga.jspm.io/npm:underscore@1.13.6/modules/index-all.js"
