<graphjs-notifications-button
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={'font-size: calc(' + height + ' * 2 / 7);'}
>
    <div class="graphjs-content">
        <a class={(authorized ? '' + (opts.open ? 'graphjs-active' : '') : 'graphjs-disabled')} data-link="list" onclick={opts.target ? handleTarget : (opts.minor ? handleToggle : handleShow)}>
            <svg class="graphjs-icon" viewBox="25 20 50 60">
                <path
                    style={opts.color ? 'fill: ' + opts.color + ' !important' : ''}
                    d="M45.5,29.0667924 C37.7364775,31.064044 32,38.1087382 32,46.4992494 L32,58.4982567 C32,59.603789 31.1017394,60.5 30.0020869,60.5 C27.7917953,60.5 26,62.2953562 26,64.5 L26,67.5029699 C26,68.0536144 26.4445307,68.5 27.0025482,68.5 L72.9974518,68.5 C73.5511439,68.5 74,68.0469637 74,67.5029699 L74,64.5 C74,62.290861 72.1998022,60.5 69.9979131,60.5 C68.8944962,60.5 68,59.6107383 68,58.4982567 L68,46.4992494 C68,38.112059 62.2647191,31.0647228 54.5,29.0668673 L54.5,27.0008537 C54.5,24.5092478 52.4852814,22.5 50,22.5 C47.5197757,22.5 45.5,24.5151008 45.5,27.0008537 L45.5,29.0667924 Z M43,70.5 L57,70.5 C57,74.3659932 53.8659932,77.5 50,77.5 C46.1340068,77.5 43,74.3659932 43,70.5 Z"
                ></path>
            </svg>
            <span if={count && count > 0} class="graphjs-count" style={opts.color ? 'color: ' + opts.color + ' !important' : ''}>{count}</span>
        </a>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getNotificationsCount from '../scripts/getNotificationsCount.js';
        import showNotificationsList from '../scripts/showNotificationsList.js';
        import showProfile from '../scripts/showProfile.js';

        analytics('notifications-button');

        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;


        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        let self = this;

        this.authorized = false;
        this.count = 0;
        this.height = opts.height || '50px';
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.failMessages = [];

        this.on('before-mount', function() {
            this.handleAuthorization();
            this.recount = setInterval(this.handleCount,  60 * 1000);
        });
        this.on('unmount', function() {
            clearInterval(this.recount);
        });

        this.restart = () => {
            this.handleAuthorization();
        }
        this.handleAuthorization = () => {
            getSession(response => {
                if(response.success) {
                    if(response.id) {
                        self.authorized = true;
                        self.update();
                        self.handleCount();
                    }
                } else {
                    self.authorized = false;
                    self.update();
                }
            });
        }
        this.handleCount = () => {
            getNotificationsCount(response => {
                if(response.success) {
                    self.count = 15;//response.count;
                    self.update();
                }
            });
        }
        this.handleToggle = event => {
            opts.toggle();
        }
        this.handleShow = event => {
            let dataset = event.target.dataset;
            switch(dataset.link) {
                case 'list':
                    showNotificationsList({
                        scroll: true
                    });
                    break;
            }
        }
        this.handleTarget = event => {
            event.preventDefault();
            document.location.href = opts.target;
        }
    </script>
</graphjs-notifications-button>