<graphjs-notifications-list
    class={'graphjs-element graphjs-root ' + boxStyle + (checked ? ' graphjs-checked' : '')}
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Notifications'}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading')}>
        <div class={'graphjs-list' + (opts.minor ? ' graphjs-scrolling' : '')} if={loaded}>
            <div each={item in notifications} if={item && notifications.length > 0} class="graphjs-item">
                <a if={item.label === 'FollowNotification'} data-link="profile" data-id={item.actor.id} onclick={opts.targetProfile ? handleTarget : handleShow}>
                    <img class="graphjs-avatar" src={item.actor.avatar ? downsizeImage(item.actor.avatar, 50) : defaultAvatar} />
                    <div class="graphjs-text">
                        <p>
                            <b>{item.actor.username}</b> followed you.
                        </p>
                    </div>
                </a>
                <a if={item.label === 'PostNotification'} data-link="feed" data-id={item.target.id} onclick={opts.targetFeedItem ? handleTarget : handleShow}>
                    <img class="graphjs-avatar" src={item.actor.avatar ? downsizeImage(item.actor.avatar, 50) : defaultAvatar} />
                    <div class="graphjs-text">
                        <p>
                            <b>{item.actor.username}</b> posted something.
                        </p>
                    </div>
                </a>
                <a if={item.label === 'MessageNotification'} data-link="message" onclick={opts.targetMessages ? handleTarget : handleShow}>
                    <img class="graphjs-avatar" src={item.actor.avatar ? downsizeImage(item.actor.avatar, 50) : defaultAvatar} />
                    <div class="graphjs-text">
                        <p>
                            <b>{item.actor.username}</b> messaged you.
                        </p>
                    </div>
                </a>
            </div>
            <div class="graphjs-placeholder graphjs-item" if={notifications.length <= 0}>
                <a onclick={handleToggle}>
                    <div class="graphjs-text">
                        <p>
                            No new notifications. You are all set!
                        </p>
                    </div>
                </a>
            </div>
            <a if={count > limit} onclick={handleNotifications}>See more</a>
        </div>
        <div if={!loaded} class="graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </div>
    <graphjs-promo properties="bottom right" detach={opts.box === 'disabled'}></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getNotifications from '../scripts/getNotifications.js';
        import showProfile from '../scripts/showProfile.js';
        import showFeedItem from '../scripts/showFeedItem.js';
        import showMessages from '../scripts/showMessages.js';

        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        analytics("notifications-list");

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        let self = this;

        this.loaded = false;
        this.notifications = [];

        this.limit = 20;
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline graphjs-promo-pad'
            : 'graphjs-box';

        this.on('before-mount', function() {
            this.handleAuthorization();
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
                        self.handleNotifications();
                    }
                } else {
                    self.authorized = false;
                    self.update();
                }
            });
        }
        this.handleNotifications = () => {
            getNotifications(response => {
                if(response.success) {
                    self.notifications = response.data ? self.notifications.concat(response.data) : [];
                    self.count = response.count;
                    self.loaded = true;
                    self.update();
                    // Trigger recount on notifications button
                    if(opts.minor) {
                        opts.recount();
                    } else {
                        document.querySelectorAll('graphjs-notifications-button').forEach(item => {
                            item._tag && item._tag.handleCount && item._tag.handleCount();
                        });
                    }
                }
            });
        }
        this.handleToggle = event => {
            opts.toggle();
        }
        this.handleTarget = event => {
            event.preventDefault();
            let dataset = event.target.dataset;
            let target;
            switch(dataset.link) {
                case 'profile':
                    target = opts.targetProfile.replace('[[id]]', dataset.id);
                    break;
                case 'feed':
                    target = opts.targetFeedItem.replace('[[id]]', dataset.id);
                    break;
                case 'message':
                    target = opts.targetMessages;
                    break;
                default:
                    target = opts.target;
            }
            if(target) document.location.href = target;
        }
        this.handleShow = event => {
            let dataset = event.target.dataset;
            switch(dataset.link) {
                case 'profile':
                    showProfile({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
                case 'feed':
                    showFeedItem({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
                case 'message':
                    showMessages();
                    break;
            }
        }
    </script>
</graphjs-notifications-list>