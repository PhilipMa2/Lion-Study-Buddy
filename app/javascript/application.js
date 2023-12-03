// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import 'select2/dist/css/select2.css';
import 'select2';

$(document).ready(function() {
    $('.select2').select2({
      theme: 'bootstrap4',
      width: '100%', // or a specific width
      placeholder: 'Select a Course',
      allowClear: true, // optional, for clearing the selected value
    });
  });
  