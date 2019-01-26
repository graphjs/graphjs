<graphjs-blog-composer
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'New Blog Post'}</div>
    </div>
    <div class="graphjs-warning" if={warningMessages.length > 0}>
        <ul if={warningMessages.length > 0} class="graphjs-fail">
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <form ref="form" if={editable}>
            <input ref="title" class="graphjs-title" type="text" placeholder={i18n.titlePlaceholder} />
            <ul class="graphjs-information">
                <li if={author} class="graphjs-author" data-authorbeforetext={i18n.authorBeforeText}>
                    <a data-link="profile" data-id={author.id} onclick={handleShow}>{author.username}</a>
                </li>
                <li class="graphjs-time" if={createTime && lastEditTime} data-createdtimebeforetext={i18n.createdTimeBeforeText} data-edittimebeforetext={i18n.editTimeBeforeText}>
                    <time if={createTime === lastEditTime}>{timeText}</time>
                    <time if={createTime !== lastEditTime} class="graphjs-edited">{timeText}</time>
                </li>
                <li class="graphjs-action">
                    <a ref="save" if={!saved && title.length > 0 && body.length > 0} onclick={save}>{i18n.saveLinkText}</a>
                    <a if={saved && title.length > 0 && body.length > 0} disabled="disabled">{i18n.savedLinkText}</a>
                    <a ref="publish" if={saved && title.length > 0 && body.length > 0 && !published} onclick={publish}>{i18n.publishLinkText}</a>
                </li>
            </ul>
        </form>
        <p if={!editable}>You don't have permission to write/edit this post.</p>
        <div if={!loaded && !blocked} class="graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <graphjs-promo if={loaded} properties="bottom right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import pell from 'pell';
        import sanitizeHTML from 'sanitize-html';
        import getSession from '../scripts/getSession.js';
        import getUser from '../scripts/getUser.js';
        import getProfile from '../scripts/getProfile.js';
        import getBlogPost from '../scripts/getBlogPost.js';
        import startBlogPost from '../scripts/startBlogPost.js';
        import editBlogPost from '../scripts/editBlogPost.js';
        import publishBlogPost from '../scripts/publishBlogPost.js';
        import unpublishBlogPost from '../scripts/unpublishBlogPost.js';
        import showBlogList from '../scripts/showBlogList.js';
        import showBlogPost from '../scripts/showBlogPost.js';
        import showLogin from '../scripts/showLogin.js';
        import login from '../scripts/login.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['blog-composer'];
        i18n = {...i18n,...opts}
        this.i18n = i18n;
        
        analytics("blog-composer");

        let loggedTime = (new Date()).getTime();

        this.blocked = false;
        this.warningMessages = [];

        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled'
            ? 'graphjs-inline'
            : 'graphjs-box';

        this.editable = false;
        this.saved = false;
        this.autoSaveTime = opts.autosave || 20;
        this.published = false;
        this.timeText = '';
        this.title = '';
        this.body = '';

        let self = this;

        this.on('before-mount', function() {
            this.handleUser();
        });
        this.on('mount', function() {
            this.loaded && this.initiate();
        });

        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser(function() {
                self.loaded && self.initiate();
            });
        }
        this.handleUser = (callback) => {
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.loaded = true;
                    self.grantAccess();
                    callback && callback();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateBlogComposer'
            });
        }
        this.grantAccess = () => {
            getUser(function(response) {
                if(response.success) {
                    if(response.editor) {
                        self.editable = true;
                        self.update();
                    }
                }
            });
        }
        this.initiate = () => {
            if(this.id) {
                // Existing Post
                getBlogPost(this.id, function(response) {
                    if(response.success) {
                        self.title = response.blog.title;
                        self.body = response.blog.summary;
                        self.author = response.blog.author;
                        self.published = !response.blog.is_draft;
                        self.createTime = response.blog.start_time * 1000;
                        self.lastEditTime = response.blog.last_edit * 1000;
                        self.saved = true;
                        self.update();
                        self.printTime(self.lastEditTime);
                        self.startEditor(self.title, self.body);
                    }
                });
            } else {
                // New Post
                startBlogPost(i18n.dummyBlogTitle, i18n.dummyBlogContent, function(response) {
                    if(response.success) {
                        self.id = response.id;
                        self.createTime = loggedTime;
                        self.lastEditTime = loggedTime;
                        getProfile(self.userId, function(response) {
                            if(response.success) {
                                self.author = {
                                    id: self.userId,
                                    username: response.profile.username
                                }
                            }
                            self.update();
                        });
                        self.saved = true;
                        self.update();
                        self.printTime(self.createTime);
                        self.startEditor();
                    }
                });
            }
        }
        this.startEditor = (preloadedTitle = '', preloadedBody = '') => {
            pell.init({
                element: self.refs.form,
                onChange: html => {
                    self.body = html;
                    self.saved = false;
                    self.update();
                },
                defaultParagraphSeparator: 'p',
                styleWithCSS: false,
                actions: [
                    'bold',
                    'italic',
                    'underline',
                    'strikethrough',
                    'heading2',
                    {
                        name: 'heading3',
                        icon: '<b>H<sub>3</sub></b>',
                        title: 'Heading 3',
                        result: () => pell.exec('formatBlock', '<h3>')
                    },
                    {
                        name: 'paragraph',
                        icon: 'P',
                        title: 'Paragraph',
                        result: () => pell.exec('formatBlock', '<p>')
                    },
                    {
                        name: 'ulist',
                        icon: icons.unorderedList,
                        title: 'Unordered List',
                        result: () => pell.exec('insertUnorderedList')
                    },
                    {
                        name: 'olist',
                        icon: icons.orderedList,
                        title: 'Ordered List',
                        result: () => pell.exec('insertOrderedList')
                    },
                    {
                        name: 'link',
                        icon: icons.link,
                        title: 'Link',
                        result: () => {
                            let url = prompt(i18n.linkPromptText);
                            if(url) pell.exec('createLink', url);
                        }
                    },
                    {
                        name: 'code',
                        icon: icons.code,
                        title: 'Code',
                        result: () => pell.exec('formatBlock', '<pre>')
                    },
                    {
                        name: 'quote',
                        icon: icons.quote,
                        title: 'Quote',
                        result: () => pell.exec('formatBlock', '<blockquote>')
                    },
                    {
                        name: 'image',
                        icon: icons.image,
                        title: 'Image',
                        result: () => {
                            let url = prompt(i18n.imagePromptText);
                            if(url) pell.exec('insertImage', url);
                        }
                    }
                ],
                classes: {
                    actionbar: 'graphjs-toolbar',
                    button: 'graphjs-tool',
                    selected: 'graphjs-selected',
                    content: 'graphjs-body graphjs-article'
                }
            });
            let form = this.refs.form;
            let title = form.querySelector('input.graphjs-title');
            title.value = preloadedTitle;
            let body = form.querySelector('div.graphjs-body');
            body.innerHTML = preloadedBody;
            this.watch();
        }
        this.watch = () => {
            let form = this.refs.form;
            let title = form.querySelector('input.graphjs-title');
            let body = form.querySelector('div.graphjs-body');
            title.addEventListener('keyup', function() {
                self.title = title.value;
                self.saved = false;
                self.update();
            });
            body.addEventListener('paste', function(event) {
                event.preventDefault();
                event.stopPropagation();
                let copied = event.clipboardData || window.clipboardData;
                let paste = copied.getData('text/html') || copied.getData('text');
                if(copied.types.indexOf('text/html') !== -1) {
                    paste = sanitizeHTML(paste, {
                        allowedTags: [
                            'br', // New line
                            'b', 'i', 'u', 'strike', // Styled text
                            'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'p', // Title & paragraph
                            'ul', 'ol', 'li', // List
                            'a', 'pre', 'blockquote', 'img' // Others
                        ],
                        allowedAttributes: {
                            'a': ['href', 'target'],
                            'img': ['src', 'alt']
                        },
                        selfClosing: ['img', 'br', 'hr'],
                        allowedSchemes: ['http', 'https', 'ftp', 'mailto'],
                        allowedSchemesAppliedToAttributes: ['href', 'src'],
                        allowProtocolRelative: true,
                        allowedIframeHostnames: ['www.youtube.com', 'player.vimeo.com'],
                        transformTags: {
                            'h1': 'h2',
                            'h2': 'h3',
                            'h3': 'h4',
                            'h4': 'h4',
                            'h5': 'h4',
                            'h6': 'h4',
                            'em': 'b',
                            'strong': 'b',
                            's': 'strike',
                            'del': 'strike',
                            'code': 'pre',
                            'xmp': 'pre'
                        }
                    });
                }
                let selection = window.getSelection();
                if (!selection.rangeCount) return false;
                let element = document.createElement('span');
                element.innerHTML = paste;
                let range = selection.getRangeAt(0);
                range.insertNode(element);
                range = range.cloneRange();
                range.selectNodeContents(element);
                range.collapse(false);
                selection.removeAllRanges();
                selection.addRange(range);
                self.body = document.querySelector('.graphjs-body').innerHTML;
                self.update();
            });
            !this.published && this.autoSave();
        }
        this.save = (event) => {
            let link = this.refs.save;
            if(this.validateForm) {
                if(event) {
                    event.currentTarget.setAttribute('disabled', 'disabled');
                    event.currentTarget.innerHTML = i18n.saveProgessText;
                }
                editBlogPost(self.id, self.title, self.body, function(response) {
                    if(response.success) {
                        self.saved = true;
                        self.update();
                    } else {
                        if(link) {
                            link.setAttribute('disabled', 'disabled');
                            link.innerHTML = i18n.saveErrorText;
                            setTimeout(function() {
                                link.removeAttribute('disabled');
                                link.innerHTML = i18n.saveLinkText;
                            }, 2500);
                        }
                    }
                });
            }
        }
        this.autoSave = () => {
            if(this.autoSaveTime > 0) {
                let time = this.autoSaveTime > 20 ? this.autoSaveTime : 20;
                let autoSave = setInterval(function() {
                    if(!self.published) {
                        if(!self.saved) self.save();
                    } else {
                        clearInterval(autoSave);
                    }
                }, time * 1000);
            }

        }
        this.publish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = i18n.publishProgressText;
            publishBlogPost(self.id, function(response) {
                if(response.success) {
                    if(opts.minor) {
                        self.handleCallback({
                            link: 'post',
                            id: self.id
                        });
                    } else {
                        link.innerHTML = 'Published!';
                        setTimeout(function() {
                            self.published = true;
                            self.update();
                        }, 500);
                    }
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = i18n.publishErrorText;
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = i18n.publishLinkText;
                        }, 2500);
                    }
                }
            });
        }
        this.unpublish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = i18n.unpublishProgressText;
            unpublishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = false;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = i18n.unpublishErrorText;
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = 'unpublishLinkText';
                        }, 2500);
                    }
                }
            });
        }
        this.printTime = (timestamp) => {
            if(timestamp) {
                let time = new Date(timestamp);
                this.timeText = this.months[time.getMonth()] + ' ' + time.getDate();
                this.update();
            } else {
                this.timeText = '';
                this.update();
            }
        }
        this.checkTitle = () => {
            let warningMessage = i18n.titleLengthErrorText;
            if(this.refs.title.value.length >= 1) {
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.checkTextBody = () => {
            let warningMessage = i18n.postLengthErrorText;
            let form = self.refs.form;
            let body = form.querySelector('div.graphjs-body');
            if(body.innerHTML.length >= 1) {
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.validateForm = () => {
            let validTitle = this.checkTitle();
            let validTextBody = this.checkTextBody();
            if(
                validTitle && validTextBody
            ) {
                return true;
            } else {
                this.refs.submit.classList.remove('graphjs-loading');
                return false;
            }
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
                case 'list':
                    showBlogList({
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

        const icons = {
            unorderedList: '<svg viewBox="0 0 12 16"><path fill-rule="evenodd" d="M2 13c0 .59 0 1-.59 1H.59C0 14 0 13.59 0 13c0-.59 0-1 .59-1h.81c.59 0 .59.41.59 1H2zm2.59-9h6.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1H4.59C4 2 4 2.41 4 3c0 .59 0 1 .59 1zM1.41 7H.59C0 7 0 7.41 0 8c0 .59 0 1 .59 1h.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1h.01zm0-5H.59C0 2 0 2.41 0 3c0 .59 0 1 .59 1h.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1h.01zm10 5H4.59C4 7 4 7.41 4 8c0 .59 0 1 .59 1h6.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1h.01zm0 5H4.59C4 12 4 12.41 4 13c0 .59 0 1 .59 1h6.81c.59 0 .59-.41.59-1 0-.59 0-1-.59-1h.01z"></path></svg>',
            orderedList: '<svg viewBox="0 0 12 16"><path fill-rule="evenodd" d="M12 12.99c0 .589 0 .998-.59.998H4.597c-.59 0-.59-.41-.59-.999 0-.59 0-.999.59-.999H11.4c.59 0 .59.41.59 1H12zM4.596 3.996H11.4c.59 0 .59-.41.59-1 0-.589 0-.999-.59-.999H4.596c-.59 0-.59.41-.59 1 0 .589 0 .999.59.999zM11.4 6.994H4.596c-.59 0-.59.41-.59 1 0 .589 0 .999.59.999H11.4c.59 0 .59-.41.59-1 0-.59 0-.999-.59-.999zM2.008 1h-.72C.99 1.19.71 1.25.26 1.34V2h.75v2.138H.17v.859h2.837v-.86h-.999V1zm.25 8.123c-.17 0-.45.03-.66.06.53-.56 1.14-1.249 1.14-1.888-.02-.78-.56-1.299-1.36-1.299-.589 0-.968.2-1.378.64l.58.579c.19-.19.38-.38.639-.38.28 0 .48.16.48.52 0 .53-.77 1.199-1.699 2.058v.58h2.998l-.09-.88h-.66l.01.01zm-.08 3.777v-.03c.44-.19.64-.47.64-.859 0-.7-.56-1.11-1.44-1.11-.479 0-.888.19-1.278.52l.55.64c.25-.2.44-.31.689-.31.27 0 .42.13.42.36 0 .27-.2.44-.86.44v.749c.83 0 .98.17.98.47 0 .25-.23.38-.58.38-.28 0-.56-.14-.81-.38l-.479.659c.3.36.77.56 1.409.56.83 0 1.529-.41 1.529-1.16 0-.5-.31-.809-.77-.939v.01z"></path></svg>',
            quote: '<svg viewBox="0 0 14 16"><path fill-rule="evenodd" d="M6.16 3.5C3.73 5.06 2.55 6.67 2.55 9.36c.16-.05.3-.05.44-.05 1.27 0 2.5.86 2.5 2.41 0 1.61-1.03 2.61-2.5 2.61-1.9 0-2.99-1.52-2.99-4.25 0-3.8 1.75-6.53 5.02-8.42L6.16 3.5zm7 0c-2.43 1.56-3.61 3.17-3.61 5.86.16-.05.3-.05.44-.05 1.27 0 2.5.86 2.5 2.41 0 1.61-1.03 2.61-2.5 2.61-1.89 0-2.98-1.52-2.98-4.25 0-3.8 1.75-6.53 5.02-8.42l1.14 1.84h-.01z"></path></svg>',
            code: '<svg viewBox="0 0 14 16"><path fill-rule="evenodd" d="M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4.5 5L6 11.5 2.5 8 6 4.5 4.5 3z"></path></svg>',
            link: '<svg viewBox="0 0 100 125"><path d="M59.178,73.35L44.99,87.532c-9.524,9.526-24.634,10.003-33.58,1.057s-8.469-24.057,1.061-33.583 l15.971-15.98c9.398-9.392,24.22-9.979,33.21-1.413c0.069,0.066,0.144,0.123,0.207,0.188c0.019,0.019,0.044,0.044,0.057,0.06 c0.038,0.041,0.075,0.072,0.113,0.11l-0.013,0.01c2.555,2.727,2.505,7.006-0.157,9.668c-2.718,2.718-7.125,2.718-9.844,0 c-0.006-0.01-0.031-0.035-0.031-0.035c-4.118-4.115-10.986-3.814-15.387,0.584l-14.96,14.961 c-4.395,4.395-4.633,11.592-0.509,15.713s11.319,3.889,15.714-0.509l5.543-5.543c0,0,2.53,0.979,7.439,1.475 C54.57,74.778,59.178,73.35,59.178,73.35z M88.59,11.41c-8.946-8.946-24.063-8.466-33.58,1.057L40.822,26.649 c0,0,4.608-1.429,9.354-0.945c4.909,0.496,7.433,1.479,7.433,1.479l5.55-5.547c4.395-4.395,11.589-4.626,15.707-0.505 c4.125,4.118,3.892,11.319-0.502,15.71l-14.96,14.961c-4.401,4.398-11.269,4.699-15.387,0.583c0,0-0.025-0.025-0.031-0.035 c-2.718-2.718-7.125-2.718-9.844,0c-2.668,2.665-2.718,6.943-0.163,9.671l-0.006,0.01c0.038,0.037,0.075,0.066,0.113,0.107 c0.013,0.015,0.038,0.04,0.05,0.062c0.069,0.066,0.144,0.12,0.213,0.183c8.99,8.569,23.806,7.985,33.21-1.41l15.971-15.98 C97.059,35.469,97.536,20.352,88.59,11.41z"/></svg>',
            image: '<svg viewBox="0 0 100 125"><path d="M67.4,36.9L44.7,65.6L34.1,54c-2-2.2-5.5-2.2-7.5,0L14.3,67.4v17.4c0,0.5,0.4,0.9,0.9,0.9h69.6c0.5,0,0.9-0.4,0.9-0.9 V50.4L75,36.9C73.1,34.4,69.4,34.4,67.4,36.9z"/><circle cx="28.9" cy="28.6" r="9"/><path d="M84.8,2.5H15.2c-7,0-12.7,5.7-12.7,12.7v69.6c0,7,5.7,12.7,12.7,12.7h69.6c7,0,12.7-5.7,12.7-12.7V15.2 C97.5,8.2,91.8,2.5,84.8,2.5z M90.4,84.8c0,3.1-2.5,5.6-5.6,5.6H15.2c-3.1,0-5.6-2.5-5.6-5.6V15.2c0-3.1,2.5-5.6,5.6-5.6h69.6 c3.1,0,5.6,2.5,5.6,5.6V84.8z"/></svg>',
        }
    </script>
</graphjs-blog-composer>