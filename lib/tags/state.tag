<graphjs-state class={!opts.flat && 'box'}>
    <div class="not-logged" if={!id}>
        <a onclick={handleLoginBox}>Login</a>
        <a onclick={handleRegisterBox}>Register</a>
    </div>
    <div class="logged" if={id}>
        <a class="details" if={profile}>
            <img src={profile.avatar || 'lib/images/avatars/user.png'} />
            <span>{profile.fullname || profile.username}</span>
        </a>
        <a class="exit" onclick={handleExit}>
            <svg viewBox="0 0 20 18" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g transform="translate(-17.000000, -16.000000)" fill="black" fill-rule="nonzero">
                        <path d="M19.9086651,31.0702576 L25.9789227,31.0702576 L25.9789227,34 L17,34 L17,16 L26,16 L26,18.9297424 L19.9086651,18.9297424 L19.9086651,31.0702576 Z M29.3157895,21.0187266 L31.4210526,23.0580524 L23,23.0580524 L23,25.9213483 L31.4210526,25.9213483 L29.3157895,27.9812734 L31.3789474,30 L37,24.5 L31.3789474,19 L29.3157895,21.0187266 Z"></path>
                    </g>
                </g>
            </svg>
        </a>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/state.less';
    </style>
    <script>
        import getUser from '../scripts/getUser.js';
        import getProfile from '../scripts/getProfile.js';
        import logout from '../scripts/logout.js'

        import showLoginBox from '../scripts/showLoginBox.js';
        this.handleLoginBox = () => showLoginBox();

        import showRegisterBox from '../scripts/showRegisterBox.js';
        this.handleRegisterBox = () => showRegisterBox();

        this.handleState = () => {
            let self = this;
            getUser(function(response) {
                if(response.success) {
                    self.id = response.id;
                    self.handleInformation(self.id);
                } else {
                    //Handle errors
                }
            });
        }
        this.handleInformation = (id) => {
            let self = this;
            getProfile(id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleExit = () => {
            let self = this;
            logout(function(response) {
                if(response.success) {
                    self.id = undefined;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }

        this.on('before-mount', function() {
            this.handleState();
        });

        this.root.classList.add(opts.theme || 'light');
    </script>
</graphjs-state>