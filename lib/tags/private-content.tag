<graphjs-private-content
    class="graphjs-element graphjs-root"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div if={!contentReady} ref="content" class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div class="graphjs-placeholder">
            <div if={type === 'text'} class="graphjs-text">
                <div
                    class="graphjs-text-wrapper"
                    style="
                        filter: url(#light-blur);
                    "
                >
                    <h1>{i18n.title}</h1>
                    <h2>{i18n.subTitle}</h2>
                    <p>Phasellus vitae lorem aliquet, egestas metus ac, iaculis erat. Aenean quis est placerat leo lobortis hendrerit vel ut erat. Duis ultricies pellentesque ultrices. Nam eget commodo ex.</p>
                    <p>Mauris facilisis, diam id semper auctor, enim ligula placerat nibh, ac accumsan eros nisl eu nibh. Aliquam aliquam felis quis erat posuere suscipit. Vestibulum ut pharetra nulla. Donec tempus varius neque ut egestas. Phasellus pretium a neque congue facilisis.</p>
                    <p>Sed lacinia nulla lacus, non gravida odio consequat at. Suspendisse aliquet pellentesque nisi, id accumsan erat auctor in. Suspendisse elementum consectetur lectus ut malesuada.</p>
                    <p>Curabitur vestibulum blandit orci, sit amet efficitur nisl sollicitudin at. Nulla et fringilla neque. Mauris vel nulla justo. Integer in feugiat quam. Etiam ligula tortor, tristique at lacinia vel, pretium non urna.</p>
                    <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis vitae risus posuere, condimentum sapien sit amet, pretium velit. Aliquam quam odio, molestie ac congue non, pulvinar at sem. Integer et tristique felis, vitae ornare mauris. Mauris at risus sem. Aenean id laoreet felis.</p>
                </div>
            </div>
            <div if={type === 'image'} class="graphjs-image">
                <div
                    class="graphjs-media-wrapper"
                    style="
                        filter: url(#hard-blur);
                        background-image: url(https://res.cloudinary.com/graphjs/image/upload/graphjs/content/placeholders/single-image.png);
                    "
                > </div>
            </div>
            <div if={type === 'video'} class="graphjs-video">
                <div
                    class="graphjs-media-wrapper"
                    style="
                        filter: url(#hard-blur);
                        background-image: url(https://res.cloudinary.com/graphjs/image/upload/graphjs/content/placeholders/single-video.png);
                    "
                > </div>
            </div>
            <div if={type === 'album'} class="graphjs-album">
                <div
                    each={item in Array(6)}
                    class="graphjs-media-wrapper"
                    style="
                        filter: url(#hard-blur);
                        background-image: url(https://res.cloudinary.com/graphjs/image/upload/graphjs/content/placeholders/single-image.png);
                    "
                > </div>
            </div>
            <div if={type === 'mixed'} class="graphjs-mixed">
                <div
                    class="graphjs-mixed-wrapper"
                    style="
                        filter: url(#light-blur);
                    "
                >
                    <h1>{i18n.title}</h1>
                    <h2>{i18n.subTitle}</h2>
                    <div
                        class="graphjs-media-wrapper"
                        style="background-image: url(https://res.cloudinary.com/graphjs/image/upload/graphjs/content/placeholders/single-image.png);"
                    > </div>
                    <p>Phasellus vitae lorem aliquet, egestas metus ac, iaculis erat. Aenean quis est placerat leo lobortis hendrerit vel ut erat. Duis ultricies pellentesque ultrices. Nam eget commodo ex.</p>
                    <p>Mauris facilisis, diam id semper auctor, enim ligula placerat nibh, ac accumsan eros nisl eu nibh. Aliquam aliquam felis quis erat posuere suscipit. Vestibulum ut pharetra nulla. Donec tempus varius neque ut egestas. Phasellus pretium a neque congue facilisis.</p>
                    <p>Sed lacinia nulla lacus, non gravida odio consequat at. Suspendisse aliquet pellentesque nisi, id accumsan erat auctor in. Suspendisse elementum consectetur lectus ut malesuada.</p>
                    <p>Curabitur vestibulum blandit orci, sit amet efficitur nisl sollicitudin at. Nulla et fringilla neque. Mauris vel nulla justo. Integer in feugiat quam. Etiam ligula tortor, tristique at lacinia vel, pretium non urna.</p>
                    <p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis vitae risus posuere, condimentum sapien sit amet, pretium velit. Aliquam quam odio, molestie ac congue non, pulvinar at sem. Integer et tristique felis, vitae ornare mauris. Mauris at risus sem. Aenean id laoreet felis.</p>
                </div>
            </div>
            <div if={type === 'custom'} class="graphjs-custom" style="filter: url(#hard-blur);">
                <yield />
            </div>
        </div>
        <button ref="blockageButton" if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
        <svg class="graphjs-filter">
            <defs>
                <filter id="light-blur">
                    <feGaussianBlur stdDeviation="7.5" />
                </filter>
                <filter id="hard-blur">
                    <feGaussianBlur stdDeviation="10" />
                </filter>
            </defs>
        </svg>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getPrivateContent from '../scripts/getPrivateContent.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("private-content");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['private-i18n'];
        i18n = {...i18n,...opts}
        this.i18n = i18n;
        
        this.blocked = true;
        this.invalid = false;
        this.type = opts.placeholder || 'mixed';

        this.on('before-mount', function() {
            this.handleSession();
        });
        this.handleBlock = (event) => {
            event.preventDefault();
            if(!this.invalid) {
                showLogin({
                    action: 'updatePrivateContent'
                });
            }
        };
        this.restart = () => {
            this.loading = true;
            this.blocked = true;
            this.update();
            this.contentReady && this.removeContent();
            this.handleSession();
        };
        this.handleSession = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.fetchContent();
                } else {
                    self.blocked = true;
                    self.update();
                }
            });
        };
        this.addContent = (content) => {
            let parser = new DOMParser();
            let parsedHTML = parser.parseFromString(
                '<div class="graphjs-unlocked-content">' + content + '</div>',
                'text/html'
            );
            let extractedHTML = parsedHTML.getElementsByClassName('graphjs-unlocked-content')[0];
            this.root.appendChild(extractedHTML);
            this.loading = false;
            this.blocked = false;
            this.invalid = false;
            this.contentReady = true;
            this.update();
        }
        this.removeContent = () => {
            let unlockedHTML = this.root.getElementsByClassName('graphjs-unlocked-content')[0];
            this.root.removeChild(unlockedHTML);
            this.loading = true;
            this.blocked = true;
            this.contentReady = false;
            this.update();
        }
        this.fetchContent = () => {
            let self = this;
            let content_id = opts.id;
            getPrivateContent(content_id, function(response) {
                if(response.success) {
                    self.addContent(response.contents);
                }
                else {
                    if(response.reason && response.reason == 'Invalid ID') {
                        self.refs.blockageButton.innerText = i18n.errorText;
                        self.invalid = true;
                    }
                    self.blocked = true;
                    self.update();
                }
            });
        };
    </script>
</graphjs-private-content>