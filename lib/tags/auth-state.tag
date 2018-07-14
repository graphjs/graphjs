<graphjs-auth-state
    class={'graphjs-root graphjs-' + theme + (opts.type == 'inline' ? ' graphjs-inline' : ' graphjs-box')}
    style={'height: ' + height + '; line-height: ' + height + ';'}
>
    <div class="graphjs-content">
        <div class="graphjs-not-logged" if={!id}>
            <a if={!stateInformation} class="graphjs-idle">&middot; &middot; &middot;</a>
            <a if={stateInformation} class={opts.minor && opts.active == 'login' ? 'graphjs-active' : ''} data-link="login" onclick={opts.minor ? handleCallback : handleLoginBox}>Login</a>
            <a if={stateInformation} class={opts.minor && opts.active == 'register' ? 'graphjs-active' : ''} data-link="register" onclick={opts.minor ? handleCallback : handleRegisterBox}>Register</a>
        </div>
        <div class="graphjs-logged" if={id}>
            <a if={!profile} class="graphjs-idle">&middot; &middot; &middot;</a>
            <a class="graphjs-details" data-link="profile" data-id={id} onclick={handleShow} if={profile}>
                <img src={profile.avatar ? downsizeImage(profile.avatar, 40) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                <span>{profile.fullname || profile.username}</span>
            </a>
            <a class="graphjs-exit" if={profile} onclick={handleExit}>
                <svg viewBox="0 -1 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <g transform="translate(-17.000000, -16.000000)" fill="black" fill-rule="nonzero">
                            <path d="M19.9086651,31.0702576 L25.9789227,31.0702576 L25.9789227,34 L17,34 L17,16 L26,16 L26,18.9297424 L19.9086651,18.9297424 L19.9086651,31.0702576 Z M29.3157895,21.0187266 L31.4210526,23.0580524 L23,23.0580524 L23,25.9213483 L31.4210526,25.9213483 L29.3157895,27.9812734 L31.3789474,30 L37,24.5 L31.3789474,19 L29.3157895,21.0187266 Z"></path>
                        </g>
                    </g>
                </svg>
            </a>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/auth-state.less';
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import logout from '../scripts/logout.js'
        import showLogin from '../scripts/showLogin.js';
        import showRegister from '../scripts/showRegister.js';
        import showProfile from '../scripts/showProfile.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.theme = opts.theme || 'default';
        this.height = opts.height || '50px';
        this.failMessages = [];

        this.on('before-mount', function() {
            this.handleState();
        });

        this.restart = () => {
            this.handleState();
        }
        this.handleLoginBox = () => showLogin({
            action: 'updateState'
        });
        this.handleRegisterBox = () => showRegister({
            action: 'updateState'
        });
        this.handleState = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.id = response.id;
                    self.handleInformation(self.id);
                } else {
                    //Handle errors
                    self.stateInformation = true;
                    self.update();
                }
            });
        }
        this.handleInformation = (id) => {
            let self = this;
            getProfile(id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.stateInformation = true;
                    self.update();
                } else {
                    self.stateInformation = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleCallback = (event) => {
            event.target.classList.contains('graphjs-active')
            ? opts.callback()
            : opts.callback(event);
        }
        this.handleShow = (event) => {
            let self = this;
            let dataset = event.target.dataset;
            switch(dataset.link) {
                case 'profile':
                    showProfile({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleExit = () => {
            let self = this;
            logout(function(response) {
                if(response.success) {
                    self.id = undefined;
                    self.update();
                    Array.from(document.getElementsByClassName('graphjs-root')).forEach((item) => {
                        item._tag && item._tag.mount && item._tag.mount();
                    });
                } else {
                    //Handle errors
                }
            });
        }
    </script>
</graphjs-auth-state>