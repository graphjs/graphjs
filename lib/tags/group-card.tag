<graphjs-group-card class={'graphjs-element graphjs-root graphjs-card graphjs-box' + (loaded ? '' : ' graphjs-loading')}>
    <a class="graphjs-information" data-link="group" data-id={id} onclick={handleShow} if={group}>
        <img src={group.cover ? downsizeImage(group.cover, 240) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/covers/group.png'} />
        <b if={group}>{group.title}</b>
        <p>{group.count == 1 ? group.count + ' Member' : group.count + ' Members'}</p>
    </a>
    <button if={(!group || !joinInformation) && loaded}>&middot; &middot; &middot;</button>
    <button if={(group && joinInformation) && loaded} onclick={joined ? handleLeave : handleJoin}>{joined ? 'Leave Group' : 'Join Group'}</button>
    <div if={!loaded} class="graphjs-placeholder graphjs-loader">
        <div class="graphjs-information">
            <div class="graphjs-cover graphjs-rectangle graphjs-fill"></div>
            <div class="graphjs-title graphjs-paragraph graphjs-centered">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-description graphjs-line graphjs-centered graphjs-fill"></div>
            <div class="graphjs-button graphjs-rectangle graphjs-fill"></div>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-card.less';
    </style>
    <script>
        import getGroup from '../scripts/getGroup.js';
        import joinGroup from '../scripts/joinGroup.js';
        import leaveGroup from '../scripts/leaveGroup.js';
        import showGroup from '../scripts/showGroup.js';
        import getSession from '../scripts/getSession.js';
        import listMembers from '../scripts/listMembers.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.id = opts.id;
        this.members = opts.id;

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