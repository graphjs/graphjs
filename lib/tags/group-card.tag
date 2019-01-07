<graphjs-group-card class={'graphjs-element graphjs-root graphjs-card graphjs-box' + (loaded ? '' : ' graphjs-loading')}>
    <a if={loaded && group} class="graphjs-information" data-link="group" data-id={id} onclick={target ? handleTarget : handleShow}>
        <img src={group.cover ? downsizeImage(group.cover, 240) : 'https://raw.githubusercontent.com/phonetworks/graphjs/master/static/group.png'} />
        <b if={group}>{group.title}</b>
        <p>{ i18n.membersCountText.replace("%s",group.count) }</p>
    </a>
    <button if={loaded && (!group || !joinInformation)}>&middot; &middot; &middot;</button>
    <button if={loaded && group && joinInformation} onclick={joined ? handleLeave : handleJoin}>{joined ? i18n.leaveGroupText : i18n.joinGroupText}</button>
    <div if={!loaded} class="graphjs-placeholder graphjs-loader">
        <div class="graphjs-link">
            <div class="graphjs-cover graphjs-rectangle graphjs-fill"></div>
            <div class="graphjs-title graphjs-paragraph graphjs-centered">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-description graphjs-line graphjs-centered graphjs-fill"></div>
        </div>
        <div class="graphjs-button graphjs-rectangle graphjs-fill"></div>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import getGroup from '../scripts/getGroup.js';
        import joinGroup from '../scripts/joinGroup.js';
        import leaveGroup from '../scripts/leaveGroup.js';
        import showGroup from '../scripts/showGroup.js';
        import showLogin from '../scripts/showLogin.js';
        import getSession from '../scripts/getSession.js';
        import listMembers from '../scripts/listMembers.js';

        analytics("group-card");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['group-card'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.id = opts.id;
        this.members = opts.id;
        this.target = opts.target
        ? opts.target.replace('[[id]]', this.id)
        : undefined;

        this.on('before-mount', function() {
            this.handleInformation();
        });
        this.on('mount', function() {
            opts.theme && this.root.classList.add('graphjs-' + opts.theme);
        });

        this.handleInformation = () => {
            let self = this;
            self.id && getGroup(self.id, function(response) {
                if(response.success) {
                    self.group = response.group;
                    self.loaded = true;
                    self.update();
                    self.handleMembers();
                } else {
                    self.loaded = true;
                    //Handle errors
                }
            });
        }
        this.handleMembers = () => {
            let self = this;
            self.id && listMembers(self.id, function(response) {
                if(response.success) {
                    self.members = response.members;
                    self.update();
                    getSession(function(response) {
                        if(response.success) {
                            self.joined = self.members.includes(response.id);
                            self.joinInformation = true;
                            self.update();
                        } else {
                            //Handle errors
                        }
                    });
                } else {
                    //Handle errors
                }
            });
        };
        this.handleShow = (event) => {
            event.preventDefault();
            let dataset = event.currentTarget.dataset;
            switch(dataset.link) {
                case 'group':
                    showGroup({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleLogin = () => showLogin({
            action: 'updateState'
        });
        this.restart = () => {
            this.update();
            this.handleInformation();
        }
        this.handleTarget = (event) => {
            event.preventDefault();
            document.location.href = this.target;
        }
        this.handleJoin = () => {
            let self = this;
            joinGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleLeave = () => {
            let self = this;
            leaveGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = false;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleUpdate = () => this.update();
    </script>
</graphjs-group-card>