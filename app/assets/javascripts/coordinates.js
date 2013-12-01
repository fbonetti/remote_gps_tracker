Map = function(coordinates) {
  var _this = this;
  _this.coordinates = coordinates;
  _this.markers = [];

  _this.initialize = function() {
    createMap();
    generateMarkers();
  }

  var createMap = function() {
    var myLatlng = new google.maps.LatLng(41.901389, -87.676944);
    var mapOptions = {
      zoom: 12,
      center: myLatlng
    }

    _this.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  };

  var generateMarkers = function() {
    for (var i = 0; i < _this.coordinates.length; i++) {
      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(coordinates[i][0], coordinates[i][1]),
        map: _this.map,
        title: coordinates[i].join(", ")
      });

      _this.markers.push(marker);
    }
  };

  var deleteMarkers = function() {
    for (var i = 0; i < _this.markers.length; i++) {
      _this.markers[i].setMap(null);
    }

    _this.markers = [];
  };
}