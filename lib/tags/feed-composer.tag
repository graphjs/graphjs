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
            <graphjs-input-text ref="composer" event-input={() => handleTextInput()}></graphjs-input-text>
            <graphjs-input-file
                type={type}
                if={uploadable && type !== 'text' && !(type === 'video' && media.length > 0)}
                callback-success={handleUploadSuccess}
                callback-fail={handleUploadFail}
                callback-finish={handleUploadFinish}>
            </graphjs-input-file>
        </div>
        <div class="graphjs-media" if={media.length > 0}>
            <div each={item in media} class={'graphjs-item graphjs-' + item.type}>
                <div if={item.type === 'photo'} style={'background-image: url(' + item.url + ');'}></div>
                <img if={item.type === 'video'} src={item.cover || 'https://phonetworks.s3.us-west-2.amazonaws.com///4efc45650a8cb452a2c96f8d6e1fd8cb-1553626966-5c9a77566d792.png'} />
                <div if={item.type === 'document'}>
                    <svg viewBox="0 0 14 16">
                        <path d="M10.0053333,0 L0,0 L0,16 L14,16 L14,4 L10.0053333,0 Z M12.0053333,14 L2,14 L2,2 L9.00266667,2 L9.00266667,4.99733333 L12.0053333,4.99733333 L12.0053333,14 Z"></path>
                    </svg>
                    <b>{item.original_filename}</b>
                    <span>{item.human_filesize}</span>
                </div>
            </div>
        </div>
        <div class="graphjs-options">
            <a ref="addPhoto" onclick={() => activateFileUpload('photo')}>
                <svg viewBox="0 0 18 18">
                    <path d="M9,18 C2,18 0,15.995 0,9 C0,2.005 2,0 9,0 C16,0 18,2.005 18,9 C18,15.995 16,18 9,18 Z M9,2 C3.111,2 2,3.112 2,9 C1.988,9.211 1.981,9.458 1.981,9.707 C1.981,11.049 2.182,12.345 2.557,13.564 L5,11 L7,13 L12,8 L15.85,11.853 C15.947,11.089 16.002,10.204 16.002,9.306 C16.002,9.198 16.001,9.091 16,8.983 C16,3.11 14.89,1.999 9,1.999 L9,2 Z M5.5,7 C4.672,7 4,6.328 4,5.5 C4,4.672 4.672,4 5.5,4 C6.328,4 7,4.672 7,5.5 C7,6.328 6.328,7 5.5,7 Z"></path>
                </svg>
                <span>Photo</span>
            </a>
            <a ref="addVideo" onclick={() => activateFileUpload('video')}>
                <svg viewBox="0 0 18 18">
                    <path d="M9,18 C2,18 0,16 0,9 C0,2 2,0 9,0 C16,0 18,2 18,9 C18,16 16,18 9,18 Z M9,2 C3.111,2 2,3.113 2,9 C2,14.887 3.113,16 9,16 C14.887,16 16,14.888 16,9 C16,3.112 14.89,2 9,2 Z M7,6.00525 L12.25,9 L7,12 L7,6 L7,6.00525 Z"></path>
                </svg>
                <span>Video</span>
            </a>
            <a ref="addDocument" onclick={() => activateFileUpload('document')}>
                <svg width="18px" height="18px" viewBox="0 0 18 18" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path d="M6,10 L12,10 C12.5522847,10 13,10.4477153 13,11 C13,11.5522847 12.5522847,12 12,12 L6,12 C5.44771525,12 5,11.5522847 5,11 C5,10.4477153 5.44771525,10 6,10 Z M6,6 L12,6 C12.5522847,6 13,6.44771525 13,7 C13,7.55228475 12.5522847,8 12,8 L6,8 C5.44771525,8 5,7.55228475 5,7 C5,6.44771525 5.44771525,6 6,6 Z M9,18 C2,18 0,16 0,9 C0,2 2,0 9,0 C16,0 18,2 18,9 C18,16 16,18 9,18 Z M9,2 C3.111,2 2,3.113 2,9 C2,14.887 3.113,16 9,16 C14.887,16 16,14.888 16,9 C16,3.112 14.89,2 9,2 Z"></path>
                </svg>
                <span>Document</span>
            </a>
            <button ref="submit" onClick={handleSubmit} if={button} disabled="disabled">Post</button>
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
        import showFileUpload from '../scripts/showFileUpload.js';
        import hideOverlay from '../scripts/hideOverlay.js';
        import '../vendor/cloudinary/upload-widget.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline graphjs-overflown' : 'graphjs-box graphjs-overflown';
        this.blocked = false;
        this.uploadable = false;
        this.type = 'text';
        this.message = '';
        this.media = [];
        this.button = false;

        this.on('before-mount', () => {
            this.handleUser();
        });

        this.activateFileUpload = type => {
            this.type = type;
            this.uploadable = true;
            this.update();
        }
        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser();
        }
        this.handleUser = () => {
            getSession((response) => {
                if(response.success) {
                    this.userId = response.id;
                    this.update();
                } else {
                    this.loaded = false;
                    this.blocked = true;
                    this.update();
                    //Handle errors
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
        this.handleTextInput = () => {
            this.message = this.refs.composer.value();
            this.handleButton();
        }
        this.handleUploadSuccess = uploads => {
            // Only 1 video is accepted
            this.refs.addVideo.classList.add('disabled');
            // Multiple photos/documents are accepted
            this.type !== 'photo' && this.refs.addPhoto.classList.add('disabled');
            this.type !== 'document' && this.refs.addDocument.classList.add('disabled');
            uploads = uploads.map(upload => ({
                type: this.type,
                ...upload
            }));
            this.media = this.media.concat(uploads);
        }
        this.handleUploadFinish = () => {
            this.uploadable = false;
            this.update();
            this.handleButton();
        }
        this.handleUploadFail = response => {
            console.log('Error:', response)
            alert('There is an error occured during upload.');
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
                this.refs.submit && this.refs.submit.setAttribute('disabled', 'disabled');
            }
        }
        this.handleSubmit = (event) => {
            this.failMessages = [];
            this.refs.submit.classList.add('graphjs-loading');
            if(this.checkMessage() || this.checkMedia()) {
                let type = this.type;
                if(this.media.length > 1) {
                    type += this.type === 'photo' ? 'Album' : '';
                    type += this.type === 'document' ? 'Set' : '';
                }
                let message = this.message;
                let content = [];
                this.media.forEach(item => {
                    content.push(item.url);
                });
                updateStatus(type, message, content, (response) => {
                    if(response.success) {
                        this.refs.composer.clear();
                        this.refs.submit.classList.remove('graphjs-loading');
                        this.type = 'text';
                        this.message = '';
                        this.media = [];
                        this.update();
                        this.handleButton();
                        this.refs.addPhoto.classList.remove('disabled');
                        this.refs.addVideo.classList.remove('disabled');
                        this.refs.addDocument.classList.remove('disabled');
                        opts.push(response.id);
                    } else {
                        let failMessage = response.reason || 'Posting failed!';
                        this.failMessages = [];
                        this.failMessages.push(failMessage);
                        this.refs.submit.classList.remove('graphjs-loading');
                        this.update();
                    }
                });
            }
        }
        this.handleShow = (event) => {
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