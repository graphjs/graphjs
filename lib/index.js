var Pho = function (id) {
	/** login-form **/


	var signupTemplate = `
		<form class="form-horizontal" role="form" method="POST" action="/register">
      <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-6">
              <h2>Register New User</h2>
              <hr>
          </div>
      </div>
      <div class="row">
          <div class="col-md-3 field-label-responsive">
              <label for="name">Name</label>
          </div>
          <div class="col-md-6">
              <div class="form-group">
                  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                      <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
                      <input type="text" name="name" class="form-control" id="name"
                             placeholder="John Doe" required autofocus>
                  </div>
              </div>
          </div>
          <div class="col-md-3">
              <div class="form-control-feedback">
                      <span class="text-danger align-middle">
                          <!-- Put name validation error messages here -->
                      </span>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-3 field-label-responsive">
              <label for="email">E-Mail Address</label>
          </div>
          <div class="col-md-6">
              <div class="form-group">
                  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                      <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                      <input type="text" name="email" class="form-control" id="email"
                             placeholder="you@example.com" required autofocus>
                  </div>
              </div>
          </div>
          <div class="col-md-3">
              <div class="form-control-feedback">
                      <span class="text-danger align-middle">
                          <!-- Put e-mail validation error messages here -->
                      </span>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-3 field-label-responsive">
              <label for="password">Password</label>
          </div>
          <div class="col-md-6">
              <div class="form-group has-danger">
                  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                      <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-key"></i></div>
                      <input type="password" name="password" class="form-control" id="password"
                             placeholder="Password" required>
                  </div>
              </div>
          </div>
          <div class="col-md-3">
              <div class="form-control-feedback">
                      <span class="text-danger align-middle">
                          <i class="fa fa-close"> Example Error Message</i>
                      </span>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-3 field-label-responsive">
              <label for="password">Confirm Password</label>
          </div>
          <div class="col-md-6">
              <div class="form-group">
                  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                      <div class="input-group-addon" style="width: 2.6rem">
                          <i class="fa fa-repeat"></i>
                      </div>
                      <input type="password" name="password-confirmation" class="form-control"
                             id="password-confirm" placeholder="Password" required>
                  </div>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-6">
              <button type="submit" class="btn btn-success"><i class="fa fa-user-plus"></i> Register</button>
          </div>
      </div>
  	</form>
	`
	var LoginForm = Vue.component('login-form', {
		template: signupTemplate,
		data () {
	    return {
	    	formstate: {},
		    model: {
		      name: '',
		      email: '',
		      password: '',
		      agree: false
		    }
	    }
	  },
	  methods: {
	    fieldClassName: function (field) {
	      if(!field) {
	        return '';
	      }
	      if((field.$touched || field.$submitted) && field.$valid) {
	        return 'has-success';
	      }
	      if((field.$touched || field.$submitted) && field.$invalid) {
	        return 'has-danger';
	      }
	    },
	    onSubmit: function() {
	      console.log(this.formstate.$valid);
	    }
	  }
	})

	this.app = new Vue({
		el: id,
		data: {
			visible: true,
			host_name: '',
			visibleSignup: false
		},
		template: `
			<div class="container text-center">
				<login-form v-if="visibleSignup"></login-form>
			</div>`,
		methods: {
			showSignup() {
				this.visibleSignup = true;
			}
		},
		component: {
			'login-form': LoginForm
		}
	});
	this.signup = this.app.showSignup;
	// this.login = this.component.login;
	this.load = function (app_id) {
		loadJSON('../pho_config.json', (response) => {
			var host = JSON.parse(response).filter((config) => {
				return config.app_id == app_id;
			})
			if (host.length == 0) {
				this.app.host_name = "Not found your server";
			} else {
				this.app.host_name = host[0].host_name
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