<graphjs-profile-settings class="box">
    <div class="warning" if={warningMessages.length > 0}>
        <ul>
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class="content">
        <h2>Profile</h2>
        <a ref="uploadWidget" class="avatar">
            <img src={profile ? profile.avatar : 'lib/images/avatars/user.png'} />
        </a>
        <form>
            <input ref="username" type="text" placeholder="Enter full name" value={profile ? profile.username : ''} />
            <input ref="bio" type="text" placeholder="Enter a short bio" value={profile ? profile.about : ''} />
            <input ref="birthday" type="text" placeholder="Enter birthday (MM/DD/YYYY)" value={profile ? profile.birthday : ''} />
            <button ref="submit" onclick={handleProfileSubmit}>Set Information</button>
        </form>
        <h2>Account</h2>
        <form>
            <input ref="email" type="text" placeholder="Enter email address" value={profile ? profile.email : ''} />
            <input ref="authentication" type="password" placeholder="Enter current password" />
            <input ref="password" type="password" placeholder="Set new password" />
            <input ref="confirmation" type="password" placeholder="Confirm password" />
            <button ref="submit" onclick={handleAccountSubmit}>Change</button>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        /* @import '../styles/components/profile-settings.less'; */
        graphjs-profile-settings {
            display: block;
            width: 100%;
            .content {
                .avatar {
                    overflow: hidden;
                    display: inline-block;
                    position: relative;
                    width: 10em;
                    height: 10em;
                    margin: 0 auto;
                    margin-bottom: 1.5em;
                    .heavy-font;
                    text-transform: uppercase;
                    .border-radius(@border-radius-full);
                    &:hover {
                        &::before {
                            padding-top: 3.6em;
                            background-color: fade(@primary-color, 90%);
                        }
                    }
                    &::before {
                        content: "Change\APhoto";
                        display: inline-block;
                        position: absolute;
                        top: 0;
                        right: 0;
                        bottom: 0;
                        left: 0;
                        padding-top: 6.4em;
                        color: white;
                        line-height: 1.4em;
                        vertical-align: middle;
                        background-color: fade(@primary-color, 60%);
                        white-space: pre;
                        .transition(all .35s ease);
                    }
                    img {
                        width: 100%;
                        height: 100%;
                    }
                }
                form {
                    max-width: 24em;
                    margin: 0 auto;
                }
            }
        }
    </style>
    <script>
        import getProfile from '../scripts/getProfile.js';
        import setProfile from '../scripts/setProfile.js';
        import showAlert from '../scripts/showAlert.js';
        import '../vendor/cloudinary/upload-widget.js';

        this.warningMessages = [];

        this.handleInformation = (id) => {
            let self = this;
            getProfile(id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    let timestamp = new Date(response.profile.birthday * 1000);
                    self.profile.birthday = (timestamp.getMonth() + 1) + '/' + timestamp.getDate() + '/' + timestamp.getFullYear();
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }

        this.checkBirthday = () => {
            return true;
        }
        this.checkBio = () => {
            return true;
        }
        this.checkUsernameLength = () => {
            return true;
        }
        this.checkUsernamePattern = () => {
            return true;
        }
        this.validateProfileForm = () => {
            let validBirthday = this.checkBirthday();
            let validBio = this.checkBio();
            let validUsernameLength = this.checkUsernameLength();
            let validUsernamePattern = this.checkUsernamePattern();
            return (
                validBirthday &&
                validBio &&
                validUsernameLength &&
                validUsernamePattern
            ) ? true : false;
        }

        this.handleProfileSubmit = (event) => {
            event.preventDefault();
            let self = this;
        	this.validateProfileForm() && setProfile(
        		self.profile.avatar,
        		self.refs.birthday.value,
        		self.refs.bio.value,
        		self.refs.username.value,
                function(response) {
                    if(response.success) {
                        showAlert({
                            title: 'Update Successful!',
                            message: 'You successfully updated your settings.',
                            customoption: 'Show Profile',
                            show: 'profile'
                        });
                    } else {
                        showAlert({
                            title: 'Update Failed!',
                            message: response.reason || 'Please try updating your settings again.',
                            customoption: 'Retry',
                            show: 'profile',
                            negativeoption: 'Cancel'
                        });
                    }
                }
        	);
        }

        this.on('mount', function() {
            let self = this;
            this.handleInformation(opts.id);
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
                function(error, response) {
                    if(response) {
                        self.profile.avatar = response[0].url;
                        self.update();
                    }
                    if(error) {
                        //Handle error
                    }
                });
            }, false);
        });
    </script>
</graphjs-profile-settings>