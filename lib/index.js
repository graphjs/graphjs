var Pho = function (id) {
	this.component = new Vue({
		el: id,
		data: {
			visible: true,
			host_name: ''
		},
		template: `
			<div class="container text-center">
				<h2>{{ host_name }}</h2>
			</div>`,
		methods: {
		}
	});
	this.login = this.component.login;
	this.load = function (app_id) {
		loadJSON('../pho_config.json', (response) => {
			var host = JSON.parse(response).filter((config) => {
				return config.app_id == app_id;
			})
			if (host.length == 0) {
				this.component.host_name = "Not found your server";
			} else {
				this.component.host_name = host[0].host_name
			}
		})
	}
	return this;
}
var loadJSON = function(path, callback) {
	var xobj = new XMLHttpRequest();
      xobj.overrideMimeType("application/json");
  xobj.open('GET', path, true); // Replace 'my_data' with the path to your file
  xobj.onreadystatechange = function () {
        if (xobj.readyState == 4 && xobj.status == "200") {
          // Required use of an anonymous callback as .open will NOT return a value but simply returns undefined in asynchronous mode
          callback(xobj.responseText);
        }
  };
  xobj.send(null);
}