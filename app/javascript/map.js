function initMap(){
  let map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: $(`<%= @stamp.latitude %>`), lng: $(`<%= @stamp.longitude %>`)},
    zoom: 15
  });
}