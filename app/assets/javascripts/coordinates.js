Map = function(coordinates) {
  var _this = this;
  _this.coordinates = coordinates;
  _this.markers = [];
  _this.last_index = _this.coordinates.length - 1;

  _this.initialize = function() {
    createMap();
    generateMarkers();
  }

  var createMap = function() {
    var myLatlng = new google.maps.LatLng(_this.coordinates[_this.last_index][0], _this.coordinates[_this.last_index][1]);
    var mapOptions = {
      zoom: 12,
      center: myLatlng
    }

    _this.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  };

  var generateMarkers = function() {
    for (var i = 0; i < _this.coordinates.length; i++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(coordinates[i][0], coordinates[i][1]),
        map: _this.map,
        title: coordinates[i].join(", ")
      });

      if (i == _this.last_index)
        marker.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png')

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