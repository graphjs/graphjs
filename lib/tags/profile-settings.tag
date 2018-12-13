<graphjs-profile-settings class={'graphjs-element graphjs-root ' + boxStyle} style={!authorized ? 'display: none;' : ''}>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div if={authorized} class="graphjs-content">
        <a ref="uploadWidget" class="graphjs-avatar">
            <img src={profile && profile.avatar ? downsizeImage(profile.avatar, 160) : defaultAvatar} />
        </a>
        <h2>{i18n.profileTitle}</h2>
        <form>
            <input ref="username" type="text" placeholder={i18n.usernamePlaceholder} value={profile ? profile.username : ''} />
            <input ref="email" type="text" placeholder={i18n.emailPlaceholder} value={profile ? profile.email : ''} />
            <input ref="bio" type="text" placeholder={i18n.bioPlaceholder} value={profile ? profile.about : ''} />
            <input ref="birthday" type="text" placeholder={i18n.birthdayPlaceholder} value={profile ? profile.birthday : ''} />
            <button ref="submitProfile" onclick={handleProfileSubmit}>{i18n.submitButtonText}</button>
        </form>
        <h2>{i18n.passwordTitle}</h2>
        <form>
            <input ref="password" type="password" placeholder={i18n.passwordPlaceholder} />
            <input ref="confirmation" type="password" placeholder={i18n.confirmationPlaceholder} />
            <button ref="submitPassword" onclick={handlePasswordSubmit}>{i18n.passwordSubmitButtonText}</button>
        </form>
    </div>
    <script>
        import getSession from '../scripts/getSession.js';
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

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['profile-settings'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;
        
        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.failMessages = [];
        this.successMessages = [];

        this.on('before-mount', function() {
            this.handleAuthorization();
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
                    let failMessage = i18n.failMessage;
                    let successMessage = i18n.successMessage;
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

        this.handleAuthorization = () => {
            let self = this;
            getSession(response => {
                if(response.success) {
                    if(response.id) {
                        self.authorized = true;
                        self.handleInformation(response.id);
                    }
                }
            });
        }

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
            let failMessage = i18n.usernameMinLengthError;
            if(this.refs.username.value.length >= usernameMinimumLengthLimit) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernameMaximumLength = () => {
            let usernameMaximumLengthLimit = 36;
            let failMessage = i18n.usernameMaxLengthError.replace("%s",usernameMaximumLengthLimit);
            if(this.refs.username.value.length <= usernameMaximumLengthLimit) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkUsernamePattern = () => {
            let failMessage = i18n.usernamePatternError;
            let usernamePattern = /^[a-zA-Z0-9-_]+$/;
            if(usernamePattern.test(this.refs.username.value)) {
                this.refs.username.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.username.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkEmailPattern = () => {
            let failMessage = i18n.emailPatternError;
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(emailPattern.test(this.refs.email.value)) {
                this.refs.email.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.email.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBioMaximumLength = () => {
            let bioMaximumLengthLimit = 255;
            let failMessage = i18n.bioMaxError.replace("%s",bioMaximumLengthLimit);
            if(this.refs.bio.value.length <= bioMaximumLengthLimit) {
                this.refs.bio.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.bio.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBirthdayFormat = () => {
            let failMessage = i18n.birthdayFormatError;
            let birthdayPattern = /^\d{2}\/\d{2}\/\d{4}$/;
            if(birthdayPattern.test(this.refs.birthday.value)) {
                this.refs.birthday.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.birthday.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkBirthdayLimit = () => {
            let birthdayLimit = 13;
            let failMessage = i18n.birthdayLimitError.replace("%s",birthdayLimit);
            let birthYear = parseInt(this.refs.birthday.value.split('/')[2]);
            if(((new Date()).getFullYear() - birthYear) >= birthdayLimit) {
                this.refs.birthday.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.birthday.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMinimumLength = () => {
            let passwordMinimumLengthLimit = 5;
            let failMessage = i18n.passwordMinLengthError.replace("%s",passwordMinimumLengthLimit);
            if(this.refs.password.value.length >= passwordMinimumLengthLimit) {
                //this.refs.password.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMaximumLength = () => {
            let passwordMaximumLengthLimit = 255;
            let failMessage = i18n.passwordMaxLengthError.replace("%s",passwordMaximumLengthLimit);;
            if(this.refs.password.value.length <= passwordMaximumLengthLimit) {
                //this.refs.password.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkPasswordMatch = () => {
            let failMessage = i18n.passwordMatchError;
            if(this.refs.password.value == this.refs.confirmation.value) {
                this.refs.password.classList.remove('graphjs-error');
                this.refs.confirmation.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.password.classList.add('graphjs-error');
                this.refs.confirmation.classList.add('graphjs-error');
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
                this.refs.submitProfile.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.validatePassword = () => {
            let validPasswordMatch = this.checkPasswordMatch();
            let validPasswordMinimumLength = this.checkPasswordMinimumLength();
            let validPasswordMaximumLength = this.checkPasswordMaximumLength();
            if(
                validPasswordMatch && validPasswordMinimumLength && validPasswordMaximumLength // Password
            ) {
                return true;
            } else {
                this.refs.submitPassword.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.handleProfileSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitProfile.classList.add('graphjs-loading');
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
                            let failMessage = i18n.usernameFailMessage;
                            let successMessage = i18n.usernameSuccessMessage;
                            if(response.success) {
                                self.profile.username = username;
                                self.refs.username.classList.remove('graphjs-error');
                                self.refs.username.classList.add('graphjs-success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitProfile.classList.remove('graphjs-loading');
                                self.update();
                                self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                            } else {
                                self.refs.username.classList.remove('graphjs-success');
                                self.refs.username.classList.add('graphjs-error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitProfile.classList.remove('graphjs-loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = i18n.usernameFailMessage;
                    let successMessage = i18n.usernameSuccessMessage;
                    self.refs.username.classList.remove('graphjs-error');
                    self.refs.username.classList.add('graphjs-success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitProfile.classList.remove('graphjs-loading');
                    self.update();
                }
                if(email != self.profile.email) {
                    setEmail(
                        email,
                        function(response) {
                            let failMessage = i18n.emailFailMessage;
                            let successMessage = i18n.emailSuccessMessage;
                            if(response.success) {
                                self.profile.email = email;
                                self.refs.email.classList.remove('graphjs-error');
                                self.refs.email.classList.add('graphjs-success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitProfile.classList.remove('graphjs-loading');
                                self.update();
                                self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                            } else {
                                self.refs.email.classList.remove('graphjs-success');
                                self.refs.email.classList.add('graphjs-error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitProfile.classList.remove('graphjs-loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = i18n.emailFailMessage;
                    let successMessage = i18n.emailSuccessMessage;
                    self.refs.email.classList.remove('graphjs-error');
                    self.refs.email.classList.add('graphjs-success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitProfile.classList.remove('graphjs-loading');
                    self.update();
                }
                setBio(
                    bio,
                    function(response) {
                        let failMessage = i18n.bioFailMessage;
                        let successMessage = i18n.bioSuccessMessage;
                        if(response.success) {
                            self.profile.about = bio;
                            self.refs.bio.classList.remove('graphjs-error');
                            self.refs.bio.classList.add('graphjs-success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitProfile.classList.remove('graphjs-loading');
                            self.update();
                            self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                        } else {
                            self.refs.bio.classList.remove('graphjs-success');
                            self.refs.bio.classList.add('graphjs-error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitProfile.classList.remove('graphjs-loading');
                            self.update();
                        }
                    }
                );
                setBirthday(
            		birthday,
                    function(response) {
                        let failMessage = i18n.birthdayFailMessage;
                        let successMessage = i18n.birthdaySuccessMessage;
                        if(response.success) {
                            self.profile.birthday = birthday;
                            self.refs.birthday.classList.remove('graphjs-error');
                            self.refs.birthday.classList.add('graphjs-success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitProfile.classList.remove('graphjs-loading');
                            self.update();
                            self.parent.tags.hasOwnProperty('graphjs-profile-header') && self.parent.tags['graphjs-profile-header'].updateInformation();
                        } else {
                            self.refs.birthday.classList.remove('graphjs-success');
                            self.refs.birthday.classList.add('graphjs-error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitProfile.classList.remove('graphjs-loading');
                            self.update();
                        }
                    }
            	);
            }
        }
        this.handlePasswordSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submitPassword.classList.add('graphjs-loading');
            let password = self.refs.password.value;
            self.refs.password.className = '';
            self.refs.confirmation.className = '';
            self.failMessages = [];
            self.successMessages = [];
        	if(self.validatePassword()) {
                setPassword(
                    password,
                    function(response) {
                        let failMessage = i18n.passwordFailMessage;
                        let successMessage = i18n.passwordSuccessMessage;
                        if(response.success) {
                            self.profile.password = password;
                            self.refs.password.classList.remove('graphjs-error');
                            self.refs.confirmation.classList.remove('graphjs-error');
                            self.refs.password.classList.add('graphjs-success');
                            self.refs.confirmation.classList.add('graphjs-success');
                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                            self.refs.submitPassword.classList.remove('graphjs-loading');
                            self.update();
                        } else {
                            self.refs.password.classList.remove('graphjs-success');
                            self.refs.confirmation.classList.remove('graphjs-success');
                            self.refs.password.classList.add('graphjs-error');
                            self.refs.confirmation.classList.add('graphjs-error');
                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                            self.refs.submitPassword.classList.remove('graphjs-loading');
                            self.update();
                        }
                    }
                );
            }
        }
    </script>
</graphjs-profile-settings>
