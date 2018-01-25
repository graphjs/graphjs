var Pho = function (id) {

	var apiInstance = axios.create({
	  baseURL: 'http://phonetworks.com:1338',
	  timeout: 6000,
	  headers: {'Content-Type': 'application/json'}
	});
	/********* Signup-Form *********/

	var signupTemplate = `
		<div class="form-horizontal" >
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
              <input
              	type="text"
              	name="name"
              	class="form-control"
              	id="name"
                placeholder="Enter your name"
                required
                autofocus
                v-model.lazy="model.username"
              >
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
              <input
              	type="text"
              	name="email"
              	class="form-control"
              	id="email"
                placeholder="you@example.com"
                required
                autofocus
                v-model.lazy="model.email"
              >
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
              <input
              	type="password"
              	name="password"
              	class="form-control"
              	id="password"
                placeholder="Password"
                required
                v-model.lazy="model.password"
              >
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
          <button class="btn btn-success" @click="onRegister()"><i class="fa fa-user-plus"></i> Register</button>
        </div>
      </div>
  	</div>
	`
	var SignupForm = Vue.component('signup-form', {
		template: signupTemplate,
		data () {
	    return {
	    	formstate: {},
		    model: {
		      username: '',
		      email: '',
		      password: '',	
		    }
	    }
	  },
	  methods: {
	    onRegister: function() {
	      apiInstance.post('/signup', this.model)
			  .then(function (response) {
			    console.log(response);
			  })
			  .catch(function (error) {
			    console.log(error);
			  });
	    }
	  }
	})

	/********* Login-Form *********/
	var loginTemplate = `
		<div class="form-horizontal" >
      <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
          <h2>Log In User</h2>
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
              <input
              	type="text"
              	name="name"
              	class="form-control"
              	id="name"
                placeholder="Enter your name"
                required
                autofocus
                v-model.lazy="model.username"
              >
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
          <label for="password">Password</label>
        </div>
        <div class="col-md-6">
          <div class="form-group has-danger">
            <div class="input-group mb-2 mr-sm-2 mb-sm-0">
              <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-key"></i></div>
              <input
              	type="password"
              	name="password"
              	class="form-control"
              	id="password"
                placeholder="Password"
                required
                v-model.lazy="model.password"
              >
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
          <button class="btn btn-success" @click="onLogin()"><i class="fa fa-user-plus"></i>Log In</button>
        </div>
      </div>
  	</div>
	`
	var LoginForm = Vue.component('login-form', {
		template: loginTemplate,
		data () {
	    return {
	    	formstate: {},
		    model: {
		      username: '',
		      password: '',	
		    }
	    }
	  },
	  methods: {
	    onLogin: function() {
	      apiInstance.post('/login', this.model)
			  .then(function (response) {
			    console.log(response);
			  })
			  .catch(function (error) {
			    console.log(error);
			  });
	    }
	  }
	})

	/********* Vue Root  *********/

	this.app = new Vue({
		el: id,
		data: {
			visible: true,
			host_name: '',
			visibleFormName: ''
		},
		template: `
			<div class="container text-center">
				<signup-form v-if="visibleFormName == 'signup'"></signup-form>
				<login-form v-if="visibleFormName == 'login'"></login-form>
			</div>`,
		methods: {
			showSignup() {
				this.visibleFormName = 'signup';
			},
			showLogin() {
				this.visibleFormName = 'login';
			}
		},
		component: {
			'signup-form': SignupForm,
			'login-form': LoginForm
		}
	});
	this.signup = this.app.showSignup;
	this.login = this.app.showLogin;


	return this;
}