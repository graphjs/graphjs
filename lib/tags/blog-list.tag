<graphjs-blog-list
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Blog'}</div>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '') + (matchedPosts.length > pageLimit ? ' graphjs-pagination' : '')}>
        <div class="graphjs-list" if={loaded}>
            <div if={postsData[matchedPost]} each={matchedPost, index in matchedPosts} class={'graphjs-item' + ((index + 1 > (page - 1) * pageLimit && index + 1 <= Math.min(matchedPosts.length, page * pageLimit)) ? '' : ' graphjs-hidden')} data-link="post" data-id={matchedPost} onclick={opts.minor ? handleCallback : handleShow}>
                <h1 class="graphjs-title">{postsData[matchedPost].title}</h1>
                <ul class="graphjs-information">
                    <li class="graphjs-author">
                        <a data-link="profile" data-id={postsData[matchedPost].author.id} onclick={handleShow}>{postsData[matchedPost].author.username}</a>
                    </li>
                    <li class="graphjs-time" if={createTime && lastEditTime}>
                        <time>{printTime(postsData[matchedPost].timestamp)}</time>
                    </li>
                </ul>
                <div class="graphjs-summary">{postsData[matchedPost].summary}</div>
            </div>
            <div class="graphjs-placeholder graphjs-item" if={loaded && matchedPosts.length <= 0}>
                There isn't any post available.
            </div>
        </div>
        <div class="graphjs-controls" if={loaded && matchedPosts.length > pageLimit}>
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
            <p>{'Displaying ' + parseInt(((page - 1) * pageLimit + 1), 10) + '-' + Math.min(matchedPosts.length, parseInt(page * pageLimit, 10)) + ' of ' + matchedPosts.length}</p>
            <a class={page == Math.ceil(matchedPosts.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="next" onclick={handlePagination}>
                <svg viewBox="0 0 54 62" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-218.000000, -205.000000)" d="M270.5,238.223766 L222.7,265.823766 C220.7,267.023766 218.2,265.523766 218.2,263.223766 L218.2,208.023766 C218.2,205.723766 220.7,204.223766 222.7,205.423766 L270.5,233.023766 C272.5,234.223766 272.5,237.023766 270.5,238.223766 Z"></path>
                </svg>
            </a>
            <a class={page == Math.ceil(matchedPosts.length / pageLimit) ? 'graphjs-disabled' : ''} data-target="last" onclick={handlePagination}>
                <svg viewBox="0 0 59 59" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <path transform="translate(-172.000000, 0.000000)" d="M225.7,0.140939378 L225.1,0.140939378 C222.5,0.140939378 220.4,2.24093938 220.4,4.84093938 L220.4,24.6409394 L179,0.640939378 C175.9,-1.15906062 172,1.04093938 172,4.64093938 L172,54.1409394 C172,57.7409394 175.9,59.9409394 179,58.1409394 L220.5,34.2409394 L220.5,54.0409394 C220.5,56.6409394 222.6,58.7409394 225.2,58.7409394 L225.8,58.7409394 C228.4,58.7409394 230.5,56.6409394 230.5,54.0409394 L230.5,4.84093938 C230.4,2.24093938 228.3,0.140939378 225.7,0.140939378 Z"></path>
                </svg>
            </a>
        </div>
        <div if={!loaded} class="graphjs-placeholder graphjs-loader">
            <div class="graphjs-items">
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                    <div class="graphjs-summary graphjs-paragraph">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                    <div class="graphjs-summary graphjs-paragraph">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                    <div class="graphjs-summary graphjs-paragraph">
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                        <div class="graphjs-line graphjs-fill"></div>
                    </div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                </div>
                <div class="graphjs-item">
                    <div class="graphjs-title graphjs-line graphjs-fill"></div>
                    <div class="graphjs-information graphjs-line graphjs-fill"></div>
                </div>
            </div>
        </div>
    </div>
    <graphjs-promo if={loaded} properties="bottom right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getBlogPosts from '../scripts/getBlogPosts.js';
        import showBlogComposer from '../scripts/showBlogComposer.js';
        import showBlogPost from '../scripts/showBlogPost.js';
        import showLogin from '../scripts/showLogin.js';
        import showProfile from '../scripts/showProfile.js';

        analytics("blog-list");

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.access = opts.access || 'public';
        this.page = opts.page ? parseInt(opts.page) : 1;
        this.pageLimit = opts.limit ? parseInt(opts.limit) : 10;
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline'
            : 'graphjs-box';

        this.posts = [];
        this.postsData = {};
        this.matchedPosts = [];

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
                if(response.success) {
                    self.userId = response.id;
                    self.blocked = false;
                    self.update();
                    self.handleContent();
                } else {
                    self.blocked = false;
                    self.update();
                    self.handleContent();
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateBlogList'
            });
        }
        this.handleContent = () => {
            let self = this;
            getBlogPosts(function(response) {
                if(response.success) {
                    for(let [index, post] of response.blogs.entries()) {
                        self.posts.push(post.id);
                        self.postsData[post.id] = {
                            id: post.id,
                            title: post.title,
                            author: post.author,
                            timestamp: post.publish_time,
                            published: !post.is_draft,
                            summary: index >= 3
                                ? ''
                                : post.summary
                                    .replace(/<[^>]+>/g, ' ')
                                    .replace(/\s\s+/g, ' ')
                                    .replace(/\s+(\W)/g, '$1')
                                    .trim()
                        }
                    }
                    self.matchedPosts = self.posts.filter(item => self.postsData[item].published);
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
                case 'profile':
                    showProfile({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
                case 'composer':
                    showBlogComposer({
                        scroll: true
                    });
                    break;
                case 'post':
                    showBlogPost({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleFilter = (event) => {
            let self = this;
            self.matchedPosts = self.posts.filter(item => self.postsData[item].title.toLowerCase().startsWith(event.target.value.toLowerCase()));
        }
        this.handlePagination = (event) => {
            let self = this;
            let target = event.target.dataset.target;
            let lastPage = Math.ceil(self.matchedPosts.length / self.pageLimit);
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
        this.printTime = (timestamp) => {
            if(timestamp) {
                let time = new Date(timestamp * 1000);
                return this.months[time.getMonth()] + ' ' + time.getDate();
            } else {
                return '';
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
</graphjs-blog-list>