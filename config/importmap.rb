# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "el-transition"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "trix"

pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "flatpickr" # @4.6.13
