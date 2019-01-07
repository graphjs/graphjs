<graphjs-feed-display
    class="graphjs-root graphjs-element"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-content">
        <div class="graphjs-information">
            <div class="graphjs-credit" if={profile}>
                <img data-link="profile" data-id={profile.id} onclick={handleShow} src={profile.avatar ? downsizeImage(profile.avatar, 50) : defaultAvatar} />
                <span>
                    <b data-link="profile" data-id={profile.id} onclick={handleShow}>{profile.username || 'Unknown User'}</b>
                    <time data-timestamp={data.timestamp}>{handleTime(data.timestamp)}</time>
                </span>
            </div>
            <a onclick={handleExit}>
                <svg viewBox="0 0 26 26" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path d="M7.4605307,1.2961597 L10.39371,4.2954245 L12.826102,6.7826203 L18.233243,1.2554997 C19.891433,-0.439484 22.476884,-0.4492423 24.122326,1.2332725 C25.767768,2.9157869 25.757791,5.5590467 24.099602,7.25403 L18.692461,12.7811504 L24.058033,18.2676115 C25.703475,19.9501259 25.693498,22.5933856 24.035308,24.288369 C22.377118,25.9833529 19.791668,25.993111 18.146225,24.3105964 L12.780654,18.8241358 L10.329417,21.3297635 L7.373513,24.3512562 C5.7153233,26.04624 3.1298724,26.0559981 1.4844302,24.3734835 C-0.1610115,22.6909689 -0.1510352,20.0477094 1.5071548,18.3527258 L4.4630581,15.3312333 L6.9142954,12.8256054 L4.4819027,10.3384099 L1.5487235,7.3391446 C-0.0967183,5.65663 -0.086742,3.0133704 1.5714481,1.3183868 C3.2296376,-0.3765968 5.8150887,-0.3863552 7.4605307,1.2961597 Z"></path>
                </svg>
            </a>
        </div>
        <div class="graphjs-display">
            <div class="graphjs-container">
                <div class="graphjs-media">
                    <div if={data.type == 'photo'} class="graphjs-photo">
                        <img src={data.urls[0]} />
                    </div>
                    <div if={data.type == 'video'} class="graphjs-video">
                        <video poster={getThumbnail(data.urls[0], 1000)} controls>
                            <source src={data.urls[0]} type="video/mp4">
                        </video>
                    </div>
                    <div if={data.type == 'photoAlbum'} class="graphjs-photoalbum">
                        <a if={data.urls.length > 0} class="graphjs-left" data-direction="previous" onclick={changeMedia}>
                            <svg viewBox="0 0 176 294" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                <path d="M170.694,5.755 C163.932,-1.532 152.544,-1.956 145.256,4.806 L6.256,133.806 C2.586,137.212 0.501,141.993 0.501,147 C0.501,152.007 2.586,156.788 6.256,160.194 L145.256,289.194 C148.722,292.41 153.114,294 157.496,294 C162.329,294 167.148,292.066 170.694,288.245 C177.456,280.958 177.031,269.569 169.745,262.807 L44.961,147 L169.745,31.194 C177.031,24.431 177.456,13.042 170.694,5.755 Z" />
                            </svg>
                        </a>
                        <img src={data.urls[index]} />
                        <a if={data.urls.length > 0} class="graphjs-right" data-direction="next" onclick={changeMedia}>
                            <svg viewBox="0 0 176 294" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                <path d="M5.307,288.245 C8.854,292.067 13.672,294.001 18.504,294 C22.886,294 27.279,292.409 30.744,289.194 L169.744,160.194 C173.414,156.788 175.5,152.007 175.5,147 C175.5,141.993 173.414,137.212 169.744,133.806 L30.744,4.806 C23.46,-1.955 12.068,-1.532 5.306,5.755 C-1.457,13.042 -1.032,24.431 6.255,31.193 L131.039,147 L6.256,262.806 C-1.031,269.569 -1.456,280.958 5.307,288.245 Z" />
                            </svg>
                        </a>
                  </div>
                </div>
            </div>
        </div>
    </div>
    <graphjs-promo if={loaded} properties="bottom right"></graphjs-promo>
    <script>
        import getProfile from '../scripts/getProfile.js';

        import {downsizeImage, getThumbnail} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;
        this.getThumbnail = getThumbnail;

        this.id = opts.id;
        this.data = {};
        this.index = opts.index || 0;
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        this.on('before-mount', function() {
            this.handleContent();
            this.frequentlyUpdateTime = setInterval(this.handleTimeUpdate,  60 * 1000);
        });
        this.on('mount', function() {
            document.body.style.overflow = 'hidden';
        });
        this.on('unmount', function() {
            document.body.style.overflow = 'auto';
            clearInterval(this.frequentlyUpdateTime);
        });

        this.restart = () => {
            this.update();
        }
        this.handleContent = () => {
            this.data = window.GraphJSMedia[this.id];
            this.update();
            this.handleInformation(this.data.author.id);
        }
        this.handleInformation = (id) => {
            let self = this;
            getProfile(id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.update();
                } else {
                    self.update();
                    //Handle errors
                }
            });
        }
        this.changeMedia = (event) => {
            event.preventDefault();
            let direction = event.target.dataset.direction;
            this.index = (direction == 'next'
                ? this.index + 1
                : this.index - 1
            ) % this.data.urls.length;
            this.update();
        }
        this.handleExit = (event) => {
            event.preventDefault();
            this.unmount();
        }
        this.handleTimeUpdate = () => {
            let items = document.querySelectorAll('graphjs-feed-display time');
            for(let item of items) {
                if(item.dataset.hasOwnProperty('timestamp')) {
                    let timestamp = item.dataset.timestamp;
                    item.innerHTML = this.handleTime(timestamp);
                }
            }
        }
        this.handleTime = (timestamp) => {
            let text;
            let time = Math.floor((Date.now() - (parseInt(timestamp) * 1000)) / 1000);
            let amount;
            if(time < 1) {
                amount = time;
                text = 'Now';
            } else if(1 <= time && time < 60) {
                amount = time;
                text = amount == 1 ? amount + ' second ago' : amount + ' seconds ago';
            } else if(60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = amount == 1 ? amount + ' minute ago' : amount + ' minutes ago';
            } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = amount == 1 ? amount + ' hour ago' : amount + ' hours ago';
            } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = amount == 1 ? amount + ' day ago' : amount + ' days ago';
            } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = amount == 1 ? amount + ' week ago' : amount + ' weeks ago';
            } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = amount == 1 ? amount + ' month ago' : amount + ' months ago';
            } else if(time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = amount == 1 ? amount + ' year ago' : amount + ' years ago';
            } else {
                //Handle errors
            }
            return text;
        }
        this.months = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
        ];
    </script>
</graphjs-feed-display>
