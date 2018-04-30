<graphjs-profile-activity class="box">
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <ul if={activity.length > 0}>
            <li each={item in activity}>
                <div if={item.type == 'join'}>
                    <b>{profile.username}</b>
                    joined
                </div>
                <div if={item.type == 'follow'}>
                    <b>{profile.username}</b>
                    followed
                    <a data-link="profile" data-id={item.object.id} onclick={handleShow}>{item.object.label}</a>
                </div>
                <div if={item.type == 'create'}>
                    <b>{profile.username}</b>
                    created a new group called
                    <a data-link="group" data-id={item.object.id} onclick={handleShow}>{item.object.label}</a>
                </div>
                <div if={item.type == 'comment'}>
                    <b>{profile.username}</b>
                    commented on
                    <a href={item.object.label}>{item.object.label}</a>
                </div>
                <div if={item.type == 'start'}>
                    <b>{profile.username}</b>
                    started a new thread
                    <a data-link="thread" data-id={item.object.id} onclick={handleShow}>{item.object.label}</a>
                </div>
                <div if={item.type == 'reply'}>
                    <b>{profile.username}</b>
                    replied the thread
                    <a data-link="thread" data-id={item.object.id} onclick={handleShow}>{item.object.label}</a>
                </div>
                <div if={item.type == 'star'}>
                    <b>{profile.username}</b>
                    starred a page
                </div>
            </li>
        </ul>
        <div if={!loaded} class="placeholder loader">
            <div class="list">
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="bullet circle fill"></div>
                    <div class="paragraph">
                        <div class="line fill"></div>
                        <div class="line fill"></div>
                    </div>
                </div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to display thread</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/profile-activity.less';
        .content {
            min-height: 21em;
            .placeholder {
                display: block;
                padding: 2.5em;
                .list {
                    display: block;
                    .clearfix;
                    .item {
                        display: block;
                        height: 3em;
                        .clearfix;
                        & > * {
                            float: left;
                        }
                        .bullet {
                            position: relative;
                            left: calc(-.4em + 1px);
                            width: .8em;
                            height: .8em;
                        }
                        .paragraph {
                            width: calc(100% - 1.5em);
                            height: 3em;
                            margin-left: .5em;
                            .line {
                                height: .6em;
                                margin-bottom: .8em;
                                .border-radius(calc(.6em / 2));
                                &:last-child {
                                    margin-bottom: 0;
                                }
                            }
                        }
                    }
                }
            }
        }
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showForumThread from '../scripts/showForumThread.js';
        import showGroup from '../scripts/showGroup.js';
        import getActivityToken from '../scripts/getActivityToken.js';
        import stream from 'getstream';

        this.id = opts.id;
        this.activity = [];

        this.on('before-mount', function() {
            this.handleUser();
            this.handleInformation();
        });

        this.handleInformation = () => {
            let self = this;
            self.id && getProfile(self.id, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleContent = () => {
            let self = this;
            getActivityToken('wall', self.id, function(response) {
            	if(response.success) {
                    self.activity = [];
            		let client = stream.connect('7aeupnd8y7ag');
            		let user = client.feed('wall', self.id, response.token);
            		user.get(/* { limit: 10, offset: 0} */)
            		.then((response) => {
                        for(let result of response.results) {
                            let matches = result.txt.match(/\[(.*?)\]/g);
                            let item = {
                                type: result.verb == '_construct' ? 'join' : result.verb,
                                time: result.time
                            }
                            if(matches && matches.length > 1) {
                                let object = matches[1].slice(1, -1).split('|');
                                item['object'] = {
                                    label: object[0],
                                    id: object[1]
                                }
                            }
                            self.activity.push(item);
                        }
                        self.loaded = true;
                        self.update();
                    })
            		.catch((error) => console.log(error));
                    self.update();
            	}
            	else {
            		//Handle errors
            	}
            });
        }
        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                    self.handleContent();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
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
                case 'group':
                    showGroup({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
                case 'thread':
                    showForumThread({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleProfile = (id) => {
            let self = this;
            id && getProfile(id, function(response) {
                if(response.success) {
                    return response.profile.username;
                } else {
                    //Handle errors
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin();
        }
    </script>
</graphjs-profile-activity>