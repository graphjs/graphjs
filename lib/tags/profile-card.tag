<graphjs-profile-card class={'graphjs-root graphjs-card graphjs-box' + (loaded ? '' : ' graphjs-loading')}>
    <a onclick={following ? handleUnfollow : handleFollow} class="graphjs-left graphjs-option" if={profile && userId && userId != id}>
        <svg if={!following && followInformation} viewBox="0 0 24 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g transform="translate(-22.000000, -20.000000)" fill="black" fill-rule="nonzero">
                    <path d="M22,39.0597068 L22,37.9313549 C22,36.9492708 22.4486148,36.0089776 23.2390314,35.4239063 C25.5461933,33.6686922 27.8960803,32.4985495 28.3874204,32.2687001 C28.4515082,32.2478047 28.4942334,32.1851185 28.4942334,32.1224322 L28.4942334,30.7224401 C28.1310691,30.1164733 27.917443,29.426925 27.8319925,28.8209582 C27.6183664,28.8000628 27.3192899,28.5075271 27.0202133,27.4418615 C26.5929611,25.9791831 27.0415759,25.7702291 27.4261029,25.7911245 C27.148389,25.0179945 27.148389,24.2657599 27.3192899,23.5762115 C27.5115534,22.7612907 27.9601682,22.0926377 28.4728708,21.591148 C28.79331,21.2568215 29.1564743,20.9642859 29.5410013,20.713541 C29.8614405,20.5045869 30.2032422,20.3165283 30.5877692,20.1911559 C30.8868457,20.0866788 31.2072849,20.0239926 31.527724,20.0239926 C32.5744919,19.9195156 33.3649085,20.1702605 33.9203363,20.5045869 C34.7534781,20.9642859 35.0739173,21.5493572 35.0739173,21.5493572 C35.0739173,21.5493572 37.1888157,21.695625 36.2702234,26.0209739 C36.5479374,26.1254509 36.7615635,26.5015682 36.4197617,27.6299201 C36.0138721,29.0299123 35.6507078,29.1134939 35.415719,28.9672261 C35.3302686,29.4478204 35.1807303,29.9911009 34.924379,30.4925906 C34.924379,31.2030344 34.924379,31.850792 34.924379,32.1015368 C34.924379,32.164223 34.9671042,32.2269093 35.0311921,32.2478047 C35.5438947,32.4985495 37.8937818,33.6686922 40.2009437,35.4239063 C40.9913602,36.029873 41.439975,36.9492708 41.439975,37.9313549 L41.439975,39.0597068 C41.439975,39.5820919 41.0127228,40 40.4786576,40 L22.9399548,40 C22.4272522,39.9791046 22,39.5611965 22,39.0597068 Z M37.7770946,28.6529954 L39.0022126,28.6665402 L40.0181642,28.6777726 L39.993387,26.4367029 C39.9857886,25.7494416 40.5176988,25.2175314 41.2049602,25.2251298 C41.8922215,25.2327281 42.4360248,25.7765314 42.4436231,26.4637927 L42.4684003,28.7048623 L44.70947,28.7296396 C45.3967313,28.7372379 45.9405346,29.2810412 45.9481329,29.9683025 C45.9557313,30.6555639 45.4238211,31.187474 44.7365597,31.1798757 L42.4954901,31.1550985 L42.5067224,32.17105 L42.5202673,33.3961681 C42.5278657,34.0834295 41.9959555,34.6153396 41.3086941,34.6077413 C40.6214328,34.6001429 40.0776295,34.0563397 40.0700312,33.3690783 L40.0564863,32.1439603 L40.045254,31.1280087 L39.0293024,31.1167764 L37.8041843,31.1032315 C37.116923,31.0956331 36.5731197,30.5518299 36.5655214,29.8645685 C36.557923,29.1773072 37.0898332,28.645397 37.7770946,28.6529954 Z"></path>
                </g>
            </g>
        </svg>
        <svg if={following && followInformation} viewBox="0 0 24 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M0,19.0597068 L0,17.9313549 C0,16.9492708 0.4486148,16.0089776 1.2390314,15.4239063 C3.5461933,13.6686922 5.8960803,12.4985495 6.3874204,12.2687001 C6.4515082,12.2478047 6.4942334,12.1851185 6.4942334,12.1224322 L6.4942334,10.7224401 C6.1310691,10.1164733 5.917443,9.426925 5.8319925,8.8209582 C5.6183664,8.8000628 5.3192899,8.5075271 5.0202133,7.4418615 C4.5929611,5.9791831 5.0415759,5.7702291 5.4261029,5.7911245 C5.148389,5.0179945 5.148389,4.2657599 5.3192899,3.5762115 C5.5115534,2.7612907 5.9601682,2.0926377 6.4728708,1.591148 C6.79331,1.2568215 7.1564743,0.9642859 7.5410013,0.713541 C7.8614405,0.5045869 8.2032422,0.3165283 8.5877692,0.1911559 C8.8868457,0.0866788 9.2072849,0.0239926 9.527724,0.0239926 C10.5744919,-0.0804844 11.3649085,0.1702605 11.9203363,0.5045869 C12.7534781,0.9642859 13.0739173,1.5493572 13.0739173,1.5493572 C13.0739173,1.5493572 15.1888157,1.695625 14.2702234,6.0209739 C14.5479374,6.1254509 14.7615635,6.5015682 14.4197617,7.6299201 C14.0138721,9.0299123 13.6507078,9.1134939 13.415719,8.9672261 C13.3302686,9.4478204 13.1807303,9.9911009 12.924379,10.4925906 C12.924379,11.2030344 12.924379,11.850792 12.924379,12.1015368 C12.924379,12.164223 12.9671042,12.2269093 13.0311921,12.2478047 C13.5438947,12.4985495 15.8937818,13.6686922 18.2009437,15.4239063 C18.9913602,16.029873 19.439975,16.9492708 19.439975,17.9313549 L19.439975,19.0597068 C19.439975,19.5820919 19.0127228,20 18.4786576,20 L0.9399548,20 C0.4272522,19.9791046 0,19.5611965 0,19.0597068 Z" id="Shape" fill-rule="nonzero"></path>
            <path d="M18.1535041,10.0629214 L19.947406,10.0876986 L19.9226288,6.01321143 C19.9150304,5.32595013 20.4469406,4.79403993 21.134202,4.80163833 C21.8214633,4.80923663 22.3652666,5.35303993 22.3728649,6.04030123 L22.3976421,10.1147883 L22.419074,12.0532803 C22.4221269,12.3294058 22.2007577,12.5557246 21.9246322,12.5587774 C21.9207531,12.5588203 21.9168737,12.558818 21.9129946,12.5587706 L18.1805938,12.5131575 C17.4933325,12.5055591 16.9495292,11.9617559 16.9419309,11.2744945 C16.9343325,10.5872332 17.4662427,10.055323 18.1535041,10.0629214 Z" id="Path" transform="translate(19.683291, 8.683291) rotate(45.000000) translate(-19.683291, -8.683291) "></path>
        </svg>
    </a>
    <a class="graphjs-right graphjs-option" onclick={handleMessagesComposer} if={profile && userId && userId != id}>
        <svg viewBox="0 0 50 48" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <path d="M34.8236776,11.6342064 L4.78589421,11.6342064 C2.14105793,11.6342064 0,13.7752644 0,16.4201006 L0,36.0044835 C0,38.6493198 2.14105793,40.7903777 4.78589421,40.7903777 L19.5843829,40.7903777 L31.3602015,47.7803022 L30.7934509,40.7903777 L34.8866499,40.7903777 C37.5314861,40.7903777 39.6725441,38.6493198 39.6725441,36.0044835 L39.6725441,16.4201006 C39.6725441,13.7752644 37.4685139,11.6342064 34.8236776,11.6342064 Z M10.5478586,29.1405026 C9.22544054,29.1405026 8.12342545,28.0384875 8.12342545,26.7160694 C8.12342545,25.3936513 9.22544054,24.2916362 10.5478586,24.2916362 C11.8702767,24.2916362 12.9722918,25.3936513 12.9722918,26.7160694 C12.9722918,28.0384875 11.8702767,29.1405026 10.5478586,29.1405026 Z M19.8677586,29.1405026 C18.5453405,29.1405026 17.4433254,28.0384875 17.4433254,26.7160694 C17.4433254,25.3936513 18.5453405,24.2916362 19.8677586,24.2916362 C21.1901767,24.2916362 22.2921918,25.3936513 22.2921918,26.7160694 C22.2187241,28.0384875 21.1901767,29.1405026 19.8677586,29.1405026 Z M29.124686,29.1405026 C27.8022679,29.1405026 26.7002529,28.0384875 26.7002529,26.7160694 C26.7002529,25.3936513 27.8022679,24.2916362 29.124686,24.2916362 C30.4471041,24.2916362 31.5491192,25.3936513 31.5491192,26.7160694 C31.5491192,28.0384875 30.4471041,29.1405026 29.124686,29.1405026 Z M45.2141058,0.779999733 C47.8589421,0.779999733 50,2.9210577 50,5.56589402 L50,25.0873049 C50,27.7321412 47.8589421,29.8731992 45.2141058,29.8731992 L42.3803526,29.8731992 L42.4433249,16.523073 C42.4433249,12.3039294 39.0428212,8.90342556 34.8236776,8.90342556 L10.3904282,8.90342556 L10.3904282,5.56589402 C10.3904282,2.9210577 12.5314861,0.779999733 15.1763224,0.779999733 L45.2141058,0.779999733 Z"></path>
            </g>
        </svg>
    </a>
    <div class="graphjs-information" if={profile}>
        <img src={profile.avatar || 'lib/images/avatars/user.png'} />
        <a class="graphjs-title">{profile.fullName || profile.username}</a>
        <p class="graphjs-description">{profile.about}</p>
    </div>
    <button if={profile} data-link="profile" data-id={id} onclick={handleShow}>View Profile</button>
    <div if={!loaded} class="graphjs-placeholder graphjs-loader">
        <div class="graphjs-information">
            <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
            <div class="graphjs-title graphjs-line graphjs-fill"></div>
            <div class="graphjs-description graphjs-paragraph graphjs-centered">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-button graphjs-rectangle graphjs-fill"></div>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/profile-card.less';
    </style>
    <script>
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import follow from '../scripts/follow.js';
        import unfollow from '../scripts/unfollow.js';
        import showMessagesComposer from '../scripts/showMessagesComposer.js';
        import getSession from '../scripts/getSession.js';
        import getFollowing from '../scripts/getFollowing.js';

        this.id = opts.id;
        this.following = false;
        this.userId = undefined;

        this.on('before-mount', function() {
            this.handleInformation();
            this.handleUser();
        });
        this.on('mount', function() {
            opts.theme && this.root.classList.add('graphjs-' + opts.theme);
        });

        this.handleInformation = () => {
            let self = this;
            self.id && getProfile(self.id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.loaded = true;
                    self.update();
                } else {
                    self.loaded = true;
                    //Handle errors
                }
            });
        }
        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    getFollowing(self.userId, function(response) {
                        if(response.success) {
                            let list = Object.keys(response.following);
                            self.following = list.includes(self.id) ? true : false;
                            self.followInformation = true;
                            self.update();
                        } else {
                            //Handle errors
                        }
                    });
                    self.update();
                } else {
                    //Handle errors
                }
            });
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
        this.handleFollow = () => {
            let self = this;
            self.following = true;
            follow(self.id, function(response) {
                if(response.success) {
                    //No action required
                } else {
                    self.following = false;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleUnfollow = () => {
            let self = this;
            self.following = false;
            unfollow(self.id, function(response) {
                if(response.success) {
                    //No action required
                } else {
                    self.following = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleMessagesComposer = () => {
            let self = this;
            showMessagesComposer({
                "to": self.id,
                "close": true
            });
        }
        this.handleUpdate = () => this.update();
    </script>
</graphjs-profile-card>