<graphjs-forum-list
    class={'graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header">
        <div class="graphjs-title">{language.title}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '') + (matchedThreads.length > pageLimit ? ' graphjs-pagination' : '')}>
        <div class="graphjs-bar" if={loaded}>
            <div class="graphjs-search">
                <div class="graphjs-icon">
                    <svg viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                            <path d="M20.7680925,17.4466286 C17.9916599,20.2182136 17.582728,24.4722742 19.5628195,27.6735622 L15.5811138,31.6483159 C14.8062954,32.4217814 14.8062954,33.6464353 15.5811138,34.4199008 C16.3559322,35.1933664 17.582728,35.1933664 18.3575464,34.4199008 L22.3177294,30.4666324 C25.5246166,32.4217814 29.7861178,32.0350486 32.5625504,29.2634637 C35.8124832,26.0192053 35.8124832,20.7338573 32.5625504,17.4681138 C29.3126177,14.1808851 24.0180253,14.1808851 20.7680925,17.4466286 Z M30.1304816,26.7926709 C28.2149583,28.7048497 25.094162,28.7048497 23.1786387,26.7926709 C21.2631154,24.8804921 21.2631154,21.7651447 23.1786387,19.8529659 C25.094162,17.9407872 28.2149583,17.9407872 30.1304816,19.8529659 C32.0460048,21.7866298 32.0460048,24.8804921 30.1304816,26.7926709 Z" id="Shape" transform="translate(25.000000, 25.000000) scale(-1, 1) translate(-25.000000, -25.000000) "></path>
                        </g>
                    </svg>
                </div>
                <input onkeyup={handleFilter} type="text" placeholder={language.searchInputPlaceholder} />
            </div>
            <button data-link="compose" onclick={opts.minor ? handleCallback : handleShow}>
                <svg viewBox="0 0 21 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g transform="translate(-20.000000, -17.000000)" fill="black" fill-rule="nonzero">
                        <path d="M38.1489476,17 L22.6361271,17 C21.3968108,17 20.3925373,18.0239842 20.3925373,19.2876244 L20.3925373,30.4860904 C20.3925373,31.7497305 21.3968108,32.7737148 22.6361271,32.7737148 L24.7515117,32.7737148 L24.7515117,36.5428483 C24.7515117,36.9132256 25.1574946,37.1310946 25.4566399,36.9132256 L31.4609134,32.7737148 L38.1489476,32.7737148 C39.3882638,32.7737148 40.3925373,31.7497305 40.3925373,30.4860904 L40.3925373,19.2876244 C40.3925373,18.0239842 39.3882638,17 38.1489476,17 Z M31.2728027,25.8802653 L31.2728027,28.6472015 L29.1594735,28.6472015 L29.1594735,25.8802653 L26.3925373,25.8802653 L26.3925373,23.7669362 L29.1594735,23.7669362 L29.1594735,21 L31.2728027,21 L31.2728027,23.7669362 L34.0397388,23.7669362 L34.0397388,25.8802653 L31.2728027,25.8802653 Z"></path>
                    </g>
                </svg>
                <span>{language.newThreadButton}</span>
            </button>
        </div>
        <div class="graphjs-list" if={loaded}>
            <a each={matchedThread, index in matchedThreads} class={'graphjs-item' + ((index + 1 > (page - 1) * pageLimit && index + 1 <= Math.min(matchedThreads.length, page * pageLimit)) ? '' : ' graphjs-hidden')} data-link="thread" data-id={matchedThread} onclick={opts.minor ? handleCallback : handleShow}>
                <div class="graphjs-title">
                    {threadsData[matchedThread] && threadsData[matchedThread].title}
                </div>
                <div class="graphjs-views" if={threadsData[matchedThread].views}>
                    <svg viewBox="0 0 19 12" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(0.000000, -19.000000)" d="M18.5059451,24.5206612 C16.1180812,21.0826446 12.8730354,19 9.32185322,19 C5.77067104,19 2.52562526,21.1157025 0.137761378,24.5206612 C-0.0459204592,24.8181818 -0.0459204592,25.1818182 0.137761378,25.4793388 C2.52562526,28.9173554 5.77067104,31 9.32185322,31 C12.8730354,31 16.1180812,28.8842975 18.5059451,25.4793388 C18.7202405,25.1818182 18.7202405,24.785124 18.5059451,24.5206612 Z M13.2403991,25.2479339 C13.1179445,27.3636364 11.5260353,29.0826446 9.56676233,29.214876 C7.2095121,29.3801653 5.25023917,27.2644628 5.40330737,24.7190083 C5.52576192,22.6033058 7.11767118,20.8842975 9.0769441,20.7520661 C11.4341943,20.5867769 13.3934673,22.7024793 13.2403991,25.2479339 Z M11.4341943,25.1157025 C11.3729671,26.2396694 10.5157852,27.1652893 9.47492142,27.231405 C8.18914856,27.3305785 7.14828482,26.1735537 7.24012573,24.8181818 C7.30135301,23.6942149 8.15853492,22.768595 9.19939866,22.7024793 C10.4545579,22.6033058 11.5260353,23.7603306 11.4341943,25.1157025 Z"></path>
                    </svg>
                    {threadsData[matchedThread].views}
                </div>
                <time data-time={threadsData[matchedThread] && threadsData[matchedThread].timestamp}>
                    {threadsData[matchedThread] && handleTime(threadsData[matchedThread].timestamp)}
                </time>
                <div class="graphjs-contributors" if={threadsData[matchedThread].contributors}>
                    <img each={contributor, index in threadsData[matchedThread].contributors} src={contributor.avatar ? downsizeImage(contributor.avatar, 30) : (defaultAvatar=="gravatar" ? gravatar.url(contributor.email, {s: '30', d: 'retro'}, true) : defaultAvatar)} />
                </div>
            </a>
            <div class="graphjs-placeholder graphjs-item" if={matchedThreads.length <= 0}>
                {language.noThreadsMessage}
            </div>
        </div>
        <div class="graphjs-controls" if={loaded && matchedThreads.length > pageLimit}>
            <a class={page == 1 ? 'graphjs-disabled' : ''} data-target="first" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-316.000000, -236.000000)" d="M320.8,294.640939 L321.4,294.640939 C324,294.640939 326.1,292.540939 326.1,289.940939 L326.1,270.140939 L367.6,294.040939 C370.7,295.840939 374.6,293.640939 374.6,290.040939 L374.6,240.640939 C374.6,237.040939 370.7,234.840939 367.6,236.640939 L326,260.540939 L326,240.740939 C326,238.140939 323.9,236.040939 321.3,236.040939 L320.7,236.040939 C318.1,236.040939 316,238.140939 316,240.740939 L316,290.040939 C316.1,292.540939 318.2,294.640939 320.8,294.640939 Z"></path>
                </svg>
            </a>
            <a class={page == 1 ? 'graphjs-disabled' : ''} data-target="previous" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-288.000000, -111.000000)" d="M289.5,139.023766 L337.3,111.423766 C339.3,110.223766 341.8,111.723766 341.8,114.023766 L341.8,169.223766 C341.8,171.523766 339.3,173.023766 337.3,171.823766 L289.5,144.223766 C287.5,143.023766 287.5,140.223766 289.5,139.023766 Z"></path>
                </svg>
            </a>
            <p>{'Displaying ' + parseInt(((page - 1) * pageLimit + 1), 10) + '-' + Math.min(matchedThreads.length, parseInt(page * pageLimit, 10)) + ' of ' + matchedThreads.length}</p>
            <a class={page == Math.ceil(matchedThreads.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="next" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-218.000000, -205.000000)" d="M270.5,238.223766 L222.7,265.823766 C220.7,267.023766 218.2,265.523766 218.2,263.223766 L218.2,208.023766 C218.2,205.723766 220.7,204.223766 222.7,205.423766 L270.5,233.023766 C272.5,234.223766 272.5,237.023766 270.5,238.223766 Z"></path>
                </svg>
            </a>
            <a class={page == Math.ceil(matchedThreads.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="last" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-172.000000, 0.000000)" d="M225.7,0.140939378 L225.1,0.140939378 C222.5,0.140939378 220.4,2.24093938 220.4,4.84093938 L220.4,24.6409394 L179,0.640939378 C175.9,-1.15906062 172,1.04093938 172,4.64093938 L172,54.1409394 C172,57.7409394 175.9,59.9409394 179,58.1409394 L220.5,34.2409394 L220.5,54.0409394 C220.5,56.6409394 222.6,58.7409394 225.2,58.7409394 L225.8,58.7409394 C228.4,58.7409394 230.5,56.6409394 230.5,54.0409394 L230.5,4.84093938 C230.4,2.24093938 228.3,0.140939378 225.7,0.140939378 Z"></path>
                </svg>
            </a>
        </div>
        <div if={!loaded} class="graphjs-placeholder graphjs-loader">
            <div class="graphjs-bar graphjs-rectangle graphjs-fill"></div>
            <div class="graphjs-list">
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-time graphjs-line graphjs-fill"></div>
                    <div class="graphjs-contributors">
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                        <div class="graphjs-avatar graphjs-circle graphjs-fill"></div>
                    </div>
                </div>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{language.loginButton}</button>
    </div>
    <graphjs-promo if={loaded} properties="bottom left"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import language from '../scripts/language.js';
        import getSession from '../scripts/getSession.js';
        import getThreads from '../scripts/getThreads.js';
        import showForumCompose from '../scripts/showForumComposer.js';
        import showForumThread from '../scripts/showForumThread.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("forum-list");

        this.language = language('forum-list', opts);        
        this.defaultAvatar = opts.defaultAvatar ? opts.defaultAvatar : window.GraphJSConfig.defaultAvatar;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        import gravatar from 'gravatar';
        this.gravatar = gravatar;

        this.blocked = false;
        this.access = opts.access || 'public';
        this.page = opts.page ? parseInt(opts.page) : 1;
        this.pageLimit = opts.limit ? parseInt(opts.limit) : 10;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.threads = [];
        this.threadsData = {};
        this.matchedThreads = [];

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser();
        }
        this.handleUser = () => {
            let self = this;
            getSession(function(response) {
                if(response.success && !response.pending) {
                    self.userId = response.id;
                    self.blocked = false;
                    self.update();
                    self.handleContent();
                } else {
                    if(self.access == 'private') {
                        self.loaded = false;
                        self.blocked = true;
                        self.update();
                    } else {
                        self.blocked = false;
                        self.update();
                        self.handleContent();
                    }
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                //action: 'updateForumList'
            });
        }
        this.handleContent = () => {
            let self = this;
            getThreads(function(response) {
                if(response.success) {
                    for(let thread of response.threads) {
                        self.threads.push(thread.id);
                        self.threadsData[thread.id] = {
                            id: thread.id,
                            title: thread.title,
                            author: thread.author,
                            timestamp: thread.timestamp
                        }
                        let contributors = typeof(thread.contributors) == 'object' ? thread.contributors : {};
                        let limit = 5;
                        let count = Math.min(Object.keys(contributors).length, limit);
                        self.threadsData[thread.id]['contributors'] = {};
                        for(let i = 0; i < count; i++) {
                            let key = Object.keys(contributors)[i];
                            self.threadsData[thread.id].contributors[i] = contributors[key];
                        }
                    }
                    self.matchedThreads = self.threads;
                    self.loaded = true;
                    self.blocked = false;
                    self.update();
                } else {
                    self.loaded = false;
                    self.update();
                    //Handle error
                }
            });
        }
        this.handleCallback = (properties) => {
            if(properties.target) {
                properties.preventDefault();
                let dataset = Object.assign({}, properties.currentTarget.dataset);
                opts.callback(dataset);
            } else {
                opts.callback(properties);
            }
        }
        this.handleShow = (event) => {
            event.preventDefault();
            let dataset = event.currentTarget.dataset;
            switch(dataset.link) {
                case 'compose':
                    showForumCompose({
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
        this.handleFilter = (event) => {
            let self = this;
            self.matchedThreads = self.threads.filter(item => self.threadsData[item].title.toLowerCase().startsWith(event.target.value.toLowerCase()));
        }
        this.handlePagination = (event) => {
            let self = this;
            let target = event.target.dataset.target;
            let lastPage = Math.ceil(self.matchedThreads.length / self.pageLimit);
            switch(target) {
                case 'first':
                    self.page = 1;
                    break;
                case 'previous':
                    self.page = self.page == 1 ? 1 : self.page - 1;
                    break;
                case 'next':
                    self.page = self.page == lastPage ? lastPage : self.page + 1;
                    break;
                case 'last':
                    self.page = lastPage;
                    break;
            }
            self.update();
        }
        this.handleTime = (timestamp) => {
            let time = timestamp * 1000;
            let passedTime = Math.floor((Date.now() - time) / 1000);
            let date = new Date(time);
            if(passedTime < 60 * 60 * 24) {
                return date.getHours() + ':' + ((date.getMinutes() < 10 ? '0' : '') + date.getMinutes());
            } else if(passedTime >= 60 * 60 * 24 && passedTime < 60 * 60 * 24 * 365) {
                return this.months[date.getMonth()].substring(0, 3) + ', ' + date.getDate();
            } else {
                return this.months[date.getMonth()].substring(0, 3) + ' \'' + date.getFullYear().toString().substring(2, 4);
            }
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
</graphjs-forum-list>
