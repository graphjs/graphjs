<graphjs-feed-composer
    class={'graphjs-root graphjs-element ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class={'graphjs-content' + (blocked ? ' graphjs-loading graphjs-blocked' : '')}>
        <div class="graphjs-entry">
            <textarea ref="composer" placeholder="What's on your mind?"></textarea>
            <div class="graphjs-media" if={media.length > 0}>
                <div each={item in media} class={'graphjs-item graphjs-' + item.resource_type}>
                    <img class="graphjs-thumbnail" src={item.thumbnail_url} />
                </div>
            </div>
        </div>
        <div class="graphjs-options">
            <a ref="addPhoto">
                <svg viewBox="0 0 18 18">
                    <path transform="translate(-3.000000, 0.000000)" d="M12,18 C5,18 3,15.995 3,9 C3,2.005 5,0 12,0 C19,0 21,2.005 21,9 C21,15.995 19,18 12,18 Z M12,2 C6.111,2 5,3.112 5,9 C4.988,9.211 4.981,9.458 4.981,9.707 C4.981,11.049 5.182,12.345 5.557,13.564 L8,11 L10,13 L15,8 L18.85,11.853 C18.947,11.089 19.002,10.204 19.002,9.306 C19.002,9.198 19.001,9.091 19,8.983 C19,3.11 17.89,1.999 12,1.999 L12,2 Z M8.5,7 C7.672,7 7,6.328 7,5.5 C7,4.672 7.672,4 8.5,4 C9.328,4 10,4.672 10,5.5 C10,6.328 9.328,7 8.5,7 Z" />
                </svg>
                Add Photos
            </a>
            <a ref="addVideo">
                <svg viewBox="0 0 18 18">
                    <path transform="translate(-3.000000, 0.000000)" d="M12,18 C5,18 3,16 3,9 C3,2 5,0 12,0 C19,0 21,2 21,9 C21,16 19,18 12,18 Z M12,2 C6.111,2 5,3.113 5,9 C5,14.887 6.113,16 12,16 C17.887,16 19,14.888 19,9 C19,3.112 17.89,2 12,2 Z M10,6.00525 L15.25,9 L10,12 L10,6 L10,6.00525 Z" />
                </svg>
                Upload Video
            </a>
            <button ref="submit" if={button} onClick={handleSubmit} disabled="disabled">Post</button>
        </div>
        <div if={!loaded && !blocked} class="graphjs-inline graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">Login to post updates</button>
    </div>
    <graphjs-promo if={loaded} properties="top right"></graphjs-promo>
    <script>
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import updateStatus from '../scripts/updateStatus.js';
        import '../vendor/cloudinary/upload-widget.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.blocked = false;
        this.button = false;
        this.type = 'text';
        this.message = '';
        this.media = [];

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.on('mount', function() {
            let self = this;
            let id = GraphJSConfig.id;
            let text = this.refs.composer;
            let photo = this.refs.addPhoto;
            let video = this.refs.addVideo;
            text.addEventListener("input", function() {
                text.style.height = "";
                text.style.height = text.scrollHeight + "px";
                self.message = text.value;
                self.handleButton();
            }, false);
            photo.addEventListener("click", function() {
                cloudinary.openUploadWidget({
                    cloud_name: 'graphjs',
                    upload_preset: 'n69lnkqb',
                    multiple: true,
                    resource_type: 'image',
                    folder: id + '/users/' + self.userId + '/photos',
                    theme: 'minimal'
                },
                function(error, result) {
                    if(result) {
                        self.media = self.media.concat(result);
                        self.type = 'photo';
                        video.classList.add('disabled');
                        self.handleButton();
                    }
                    if(error) {
                        // Handle error
                    }
                });
            }, false);
            video.addEventListener("click", function() {
                cloudinary.openUploadWidget({
                    cloud_name: 'graphjs',
                    upload_preset: 'wsvzsotw',
                    multiple: false,
                    resource_type: 'video',
                    folder: id + '/users/' + self.userId + '/videos',
                    theme: 'minimal'
                },
                function(error, result) {
                    if(result) {
                        self.media = result;
                        self.type = 'video';
                        photo.classList.add('disabled');
                        video.classList.add('disabled');
                        self.handleButton();
                    }
                    if(error) {
                        // Handle error
                    }
                });
            }, false);
        });

        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser();
        }
        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.checkMedia = () => {
            let mediaMinimumLimit = 1;
            if(this.media.length >= mediaMinimumLimit) {
                return true;
            } else {
                return false;
            }
        }
        this.checkMessage = () => {
            let messageMinimumLengthLimit = 1;
            if(this.message.trim().length >= messageMinimumLengthLimit) {
                return true;
            } else {
                return false;
            }
        }
        this.handleButton = () => {
            if(this.checkMessage() || this.checkMedia()) {
                this.button = true;
                this.update();
                this.refs.submit.removeAttribute('disabled');
            } else {
                this.button = false;
                this.update();
                this.refs.submit.setAttribute('disabled', 'disabled');
            }
            this.update();
        }
        this.handleSubmit = (event) => {
            let self = this;
            self.failMessages = [];
            self.refs.submit.classList.add('graphjs-loading');
            if(self.checkMessage() || self.checkMedia()) {
                let type = self.type + (self.media.length > 1 ? 'Album' : '');
                let message = self.message;
                let content = [];
                self.media.forEach(item => {
                    content.push(item.url);
                });
                updateStatus(type, message, content, function(response) {
                    if(response.success) {
                        self.refs.composer.value = '';
                        self.refs.submit.classList.remove('graphjs-loading');
                        self.button = false;
                        self.type = 'text';
                        self.message = '';
                        self.media = [];
                        self.update();
                        self.refs.addPhoto.classList.remove('disabled');
                        self.refs.addVideo.classList.remove('disabled');
                        opts.push(response.id);
                    } else {
                        let failMessage = response.reason || 'Posting failed!';
                        self.failMessages = [];
                        self.failMessages.push(failMessage);
                        self.refs.submit.classList.remove('graphjs-loading');
                        self.update();
                    }
                });
            }
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
    </script>
</graphjs-feed-composer>
