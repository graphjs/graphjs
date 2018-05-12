<graphjs-profile-settings class="graphjs-root box">
    <div class="warning" if={failMessages.length > 0 || successMessages.length > 0}>
        <ul if={failMessages.length > 0} class="fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
        <ul if={successMessages.length > 0} class="success">
            <li each={successMessage in successMessages}>{successMessage}</li>
        </ul>
    </div>
    <div class="content">
        <a ref="uploadWidget" class="avatar">
            <img src={profile && profile.avatar ? profile.avatar : 'lib/images/avatars/user.png'} />
        </a>
        <h2>Profile</h2>
        <form>
            <input ref="username" type="text" placeholder="Enter username" value={profile ? profile.username : ''} />
            <input ref="email" type="text" placeholder="Enter email address" value={profile ? profile.email : ''} />
            <input ref="bio" type="text" placeholder="Enter a short bio" value={profile ? profile.about : ''} />
            <input ref="birthday" type="text" placeholder="Enter birthday (MM/DD/YYYY)" value={profile ? profile.birthday : ''} />
            <button ref="submitProfile" onclick={handleProfileSubmit}>Update Profile</button>
        </form>
        <h2>Password</h2>
        <form>
            <input ref="password" type="password" placeholder="Enter new password" />
            <input ref="confirmation" type="password" placeholder="Confirm new password" />
            <button ref="submitPassword" onclick={handlePasswordSubmit}>Change Password</button>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/profile-settings.less';
    </style>
    <script>
        import getProfile from '../scripts/getProfile.js';
        import setProfile from '../scripts/setProfile.js';
        import setAvatar from '../scripts/setAvatar.js';
        import setBio from '../scripts/setBio.js';
        import setBirthday from '../scripts/setBirthday.js';
        import setEmail from '../scripts/setEmail.js';
        import setPassword from '../scripts/setPassword.js';
        import setUsername from '../scripts/setUsername.js';
        import showAlert from '../scripts/showAlert.js';
        import '../vendor/cloudinary/upload-widget.js';

        this.failMessages = [];
        this.successMessages = [];

        this.on('before-mount', function() {
            this.handleInformation(opts.id);
        });
        this.on('mount', function() {
            let self = this;
            this.refs.uploadWidget.addEventListener("click", function() {
                cloudinary.openUploadWidget({
                    cloud_name: 'graphjs',
                    upload_preset: 'baafngba',
                    multiple: false,
                    cropping: 'server',
                    cropping_aspect_ratio: 1,
                    cropping_coordinates_mode: 'custom',
                    theme: 'minimal'
                },
                function(error, result) {
                    let failMessage = 'Avatar couldn\'t be set.';
                    let successMessage = 'Avatar has been set successfully.';
                    if(result) {
                        setAvatar(result[0].url, function(response) {
                            if(response.success) {
                                self.profile.avatar = result[0].url;
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.update();
                                self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                            } else {
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.update();
                            }
                        });
                        self.update();
                    }
                    if(error) {
                        self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                        self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                        self.update();
                    }
                });
            }, false);
        });

        this.handleInformation = (id) => {
            let self = this;
            getProfile(id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    //let timestamp = new Date(response.profile.birthday * 1000);
                    //self.profile.birthday = (timestamp.getMonth() + 1) + '/' + timestamp.getDate() + '/' + timestamp.getFullYear();
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.checkUsernameMinimumLength = () => {
            let usernameMinimumLengthLimit = 1;
            let failMessage = 'Username is too short!';
            if(this.refs.username.value.length >= usernameMinimumLengthLimit) {
                this.refs.username.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernameMaximumLength = () => {
            let usernameMaximumLengthLimit = 12;
            let failMessage = 'Username must be ' + usernameMaximumLengthLimit + ' characters maximum!';
            if(this.refs.username.value.length <= usernameMaximumLengthLimit) {
                this.refs.username.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernamePattern = () => {
            let failMessage = 'Username is invalid. Valid characters are letters, numbers, hyphens, and underscores.';
            let usernamePattern = /^[a-zA-Z0-9-_]+$/;
            if(usernamePattern.test(this.refs.username.value)) {
                this.refs.username.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkEmailPattern = () => {
            let failMessage = 'Email is invalid. Valid format: user@site.com';
            let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if(emailPattern.test(this.refs.email.value)) {
                this.refs.email.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.email.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBioMaximumLength = () => {
            let bioMaximumLengthLimit = 255;
            let failMessage = 'Bio must be ' + bioMaximumLengthLimit + ' characters maximum!';
            if(this.refs.bio.value.length <= bioMaximumLengthLimit) {
                this.refs.bio.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.bio.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBirthdayFormat = () => {
            let failMessage = 'Invalid birthday! Correct format: MM/DD/YYYY';
            let birthdayPattern = /^\d{2}\/\d{2}\/\d{4}$/;
            if(birthdayPattern.test(this.refs.birthday.value)) {
                this.refs.birthday.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.birthday.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBirthdayLimit = () => {
            let birthdayLimit = 13;
            let failMessage = 'You must be at least ' + birthdayLimit + ' years old to register!';
            let birthYear = parseInt(this.refs.birthday.value.split('/')[2]);
            if(((new Date()).getFullYear() - birthYear) >= birthdayLimit) {
                this.refs.birthday.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.birthday.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMinimumLength = () => {
            let passwordMinimumLengthLimit = 5;
            let failMessage = 'Password must be ' + passwordMinimumLengthLimit + ' characters minimum!';
            if(this.refs.password.value.length >= passwordMinimumLengthLimit) {
                this.refs.password.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMaximumLength = () => {
            let passwordMaximumLengthLimit = 15;
            let failMessage = 'Password must be ' + passwordMaximumLengthLimit + ' characters maximum!';
            if(this.refs.password.value.length <= passwordMaximumLengthLimit) {
                this.refs.password.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMatch = () => {
            let failMessage = 'Passwords do not match.';
            if(this.refs.password.value == this.refs.confirmation.value) {
                this.refs.confirmation.classList.remove('error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.confirmation.classList.add('error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.validateProfile = () => {
            let validUsernameMinimumLength = this.checkUsernameMinimumLength();
            let validUsernameMaximumLength = this.checkUsernameMaximumLength();
            let validUsernamePattern = this.checkUsernamePattern();
            let validEmailPattern = this.checkEmailPattern();
            let validBioMaximumLength = this.checkBioMaximumLength();
            let validBirthdayFormat = this.checkBirthdayFormat();
            let validBirthdayLimit = this.checkBirthdayLimit();
            if(
                validUsernameMinimumLength && validUsernameMaximumLength && validUsernamePattern && // Username
                validEmailPattern && // Email
                validBioMaximumLength && // Bio
                validBirthdayFormat && validBirthdayLimit // Birthday
            ) {
                return true;
            } else {
                this.refs.submitProfile.classList.remove('loading');
                return false;
            }
        }
        this.validatePassword = () => {
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            let validPasswordMaximumLength = this.checkPasswordMaximumLength();
            let validPasswordMatch = this.checkPasswordMatch();
            if(
                validPasswordMinimumLength && validPasswordMaximumLength && validPasswordMatch // Password
            ) {
                return true;
            } else {
                this.refs.submitPassword.classList.remove('loading');
                return false;
            }
        }
        this.handleProfileSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitProfile.classList.add('loading');
            let username = self.refs.username.value;
            let email = self.refs.email.value;
            let bio = self.refs.bio.value;
            let birthday = self.refs.birthday.value;
            self.refs.bio.className = '';
            self.refs.birthday.className = '';
            self.failMessages = [];
            self.successMessages = [];
        	if(self.validateProfile()) {
                if(username != self.profile.username) {
                    setUsername(
                        username,
                        function(response) {
                            let failMessage = 'Username couldn\'t be set.';
                            let successMessage = 'Username has been set successfully.';
                            if(response.success) {
                                self.profile.username = username;
                                self.refs.username.classList.remove('error');
                                self.refs.username.classList.add('success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitProfile.classList.remove('loading');
                                self.update();
                                self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                            } else {
                                self.refs.username.classList.remove('success');
                                self.refs.username.classList.add('error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitProfile.classList.remove('loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = 'Username couldn\'t be set.';
                    let successMessage = 'Username has been set successfully.';
                    self.refs.username.classList.remove('error');
                    self.refs.username.classList.add('success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitProfile.classList.remove('loading');
                    self.update();
                }
                if(email != self.profile.email) {
                    setEmail(
                        email,
                        function(response) {
                            let failMessage = 'Email couldn\'t be set.';
                            let successMessage = 'Email has been set successfully.';
                            if(response.success) {
                                self.profile.email = email;
                                self.refs.email.classList.remove('error');
                                self.refs.email.classList.add('success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitProfile.classList.remove('loading');
                                self.update();
                                self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                            } else {
                                self.refs.email.classList.remove('success');
                                self.refs.email.classList.add('error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitProfile.classList.remove('loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = 'Email couldn\'t be set.';
                    let successMessage = 'Email has been set successfully.';
                    self.refs.email.classList.remove('error');
                    self.refs.email.classList.add('success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitProfile.classList.remove('loading');
                    self.update();
                }
                setBio(
                    bio,
                    function(response) {
                        let failMessage = 'Bio couldn\'t be set.';
                        let successMessage = 'Bio has been set successfully.';
                        if(response.success) {
                            self.profile.about = bio;
                            self.refs.bio.classList.remove('error');
                            self.refs.bio.classList.add('success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitProfile.classList.remove('loading');
                            self.update();
                            self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                        } else {
                            self.refs.bio.classList.remove('success');
                            self.refs.bio.classList.add('error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitProfile.classList.remove('loading');
                            self.update();
                        }
                    }
                );
                setBirthday(
            		birthday,
                    function(response) {
                        let failMessage = 'Birthday couldn\'t be set.';
                        let successMessage = 'Birthday has been set successfully.';
                        if(response.success) {
                            self.profile.birthday = birthday;
                            self.refs.birthday.classList.remove('error');
                            self.refs.birthday.classList.add('success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitProfile.classList.remove('loading');
                            self.update();
                            self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                        } else {
                            self.refs.birthday.classList.remove('success');
                            self.refs.birthday.classList.add('error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitProfile.classList.remove('loading');
                            self.update();
                        }
                    }
            	);
            }
        }
        this.handlePasswordSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitPassword.classList.add('loading');
            let password = self.refs.password.value;
            self.refs.password.className = '';
            self.refs.confirmation.className = '';
            self.failMessages = [];
            self.successMessages = [];
        	if(self.validatePassword()) {
                setPassword(
                    password,
                    function(response) {
                        let failMessage = 'Password couldn\'t be set.';
                        let successMessage = 'Password has been set successfully.';
                        if(response.success) {
                            self.profile.password = password;
                            self.refs.password.classList.remove('error');
                            self.refs.confirmation.classList.remove('error');
                            self.refs.password.classList.add('success');
                            self.refs.confirmation.classList.add('success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitPassword.classList.remove('loading');
                            self.update();
                        } else {
                            self.refs.password.classList.remove('success');
                            self.refs.confirmation.classList.remove('success');
                            self.refs.password.classList.add('error');
                            self.refs.confirmation.classList.add('error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitPassword.classList.remove('loading');
                            self.update();
                        }
                    }
                );
            }
        }
    </script>
</graphjs-profile-settings>