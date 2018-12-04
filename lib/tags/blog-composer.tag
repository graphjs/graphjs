<graphjs-blog-composer
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-warning" if={warningMessages.length > 0}>
        <ul if={warningMessages.length > 0} class="graphjs-fail">
            <li each={warningMessage in warningMessages}>{warningMessage}</li>
        </ul>
    </div>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <form ref="form" if={editable}>
            <input ref="title" class="graphjs-title" type="text" placeholder="Enter your post title here..." />
            <ul class="graphjs-information">
                <li if={author} class="graphjs-author">
                    <a data-link="profile" data-id={author.id} onclick={handleShow}>{author.username}</a>
                </li>
                <li class="graphjs-time" if={createTime && lastEditTime}>
                    <time if={createTime === lastEditTime}>{timeText}</time>
                    <time if={createTime !== lastEditTime} class="graphjs-edited">{timeText}</time>
                </li>
                <li class="graphjs-action">
                    <a ref="save" if={!saved && title.length > 0 && body.length > 0} onclick={save}>Save</a>
                    <a if={saved && title.length > 0 && body.length > 0} disabled="disabled">Saved</a>
                    <a ref="publish" if={saved === true} onclick={publish}>Publish</a>
                </li>
            </ul>
        </form>
        <p if={!editable}>You don't have permission to write/edit this post.</p>
        <div if={!loaded && !blocked} class="graphjs-inline graphjs-loader">
            <div class="graphjs-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">Login to start a post</button>
    </div>
    <a if={loaded} class="graphjs-promo graphjs-bottom graphjs-center graphjs-rounded graphjs-detached" href="https://graphjs.com" target="_blank">
        <svg viewBox="0 0 200 76" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g transform="translate(-620.000000, -18.000000)">
                <path fill="white" d="M674.455446,35.7851486 C670.318365,35.8917598 667.03137,36.6380379 667.03137,41.2223178 L667.03137,57.4805195 L657.623762,57.4805195 L657.623762,27.8959229 L666.464646,27.8959229 L666.464646,31.0409521 L666.577991,31.0409521 C668.221489,28.0025341 670.828416,26.8831169 674.455446,26.8831169 L674.455446,35.7851486 Z M708.118812,57.4555529 L698.942919,57.4555529 L698.942919,54.2598279 L698.832366,54.2598279 C697.174072,57.2957666 693.194167,58.4675325 689.877579,58.4675325 C680.425304,58.4675325 674.455446,51.4369374 674.455446,42.6486936 C674.455446,34.0202361 680.646409,26.8831169 689.877579,26.8831169 C693.249443,26.8831169 697.008243,28.1081448 698.832366,31.0375594 L698.942919,31.0375594 L698.942919,27.8950965 L708.118812,27.8950965 L708.118812,57.4555529 Z M699.207921,42.1556606 C699.207921,37.9181313 696.044608,34.7792208 691.701755,34.7792208 C687.358902,34.7792208 684.356436,38.127392 684.356436,42.2602909 C684.356436,46.2885595 687.573364,49.5844156 691.75537,49.5844156 C696.098224,49.5844156 699.207921,46.3408747 699.207921,42.1556606 Z M746.732673,42.9848228 C746.732673,51.2489434 740.703414,58.5000428 731.659524,58.5000428 C727.974977,58.5000428 724.848694,57.4337046 722.336502,54.8211762 L722.336502,67.3506494 L713.069307,67.3506494 L713.069307,27.8961381 L721.778238,27.8961381 L721.778238,31.1484694 L721.945717,31.1484694 C724.346256,28.2693565 727.807497,26.8831169 731.603698,26.8831169 C741.205852,26.8831169 746.732673,34.4008008 746.732673,42.9848228 Z M736.831683,42.2079758 C736.831683,38.0750769 733.46962,34.7792208 728.910891,34.7792208 C724.352162,34.7792208 720.990099,38.0750769 720.990099,42.2079758 C720.990099,46.2885595 724.409146,49.5844156 728.910891,49.5844156 C733.412636,49.5844156 736.831683,46.2885595 736.831683,42.2079758 Z M777.425743,57.4805195 L768.152664,57.4805195 L768.152664,41.3681994 C768.152664,38.1670762 767.203019,35.1793612 763.180993,35.1793612 C759.158967,35.1793612 757.985876,37.6869077 757.985876,41.048087 L757.985876,57.4805195 L748.712871,57.4805195 L748.712871,18 L757.985876,18 L757.985876,30.5910846 L758.097599,30.5910846 C759.717582,27.8167778 762.957547,26.8564409 766.08579,26.8564409 C769.102309,26.8564409 772.509859,27.8701299 774.520872,30.1109161 C777.48153,33.3653914 777.425669,36.8866269 777.425669,40.9413829 L777.425743,57.4805195 Z M781.386139,58.4675325 L781.386139,54.5194805 L785.346535,54.5194805 L785.346535,58.4675325 L781.386139,58.4675325 Z M784.536438,67.3506494 C783.67726,67.3506494 786.268605,67.3506494 784.523089,67.3506494 L784.523089,64.7049266 C786.093872,64.7049266 783.861369,64.7049266 784.536438,64.7049266 C786.745755,64.7049266 788.280003,63.3219351 788.280003,60.4356921 L788.280003,26.8831169 L791.287129,26.8831169 L791.287129,60.2553019 C791.287129,65.065707 788.586853,67.3506494 784.536438,67.3506494 Z M788.316832,23.9220779 L788.316832,18 L791.287129,18 L791.287129,23.9220779 L788.316832,23.9220779 Z M809.137199,58.4675325 C804.569886,58.4675325 799.570528,56.6238667 796.237624,53.9198236 L798.027517,51.5230581 C801.483863,54.1656457 805.310531,55.6405783 809.322361,55.6405783 C813.581072,55.6405783 816.913977,53.3052683 816.913977,49.6793923 L816.913977,49.5564813 C816.913977,45.8691497 812.963868,44.5171282 808.581715,43.2880176 C803.458917,41.813085 797.780635,40.2766969 797.780635,34.6842441 L797.780635,34.561333 C797.780635,29.5219799 802.039347,25.8961039 808.149672,25.8961039 C811.91462,25.8961039 816.173332,27.2481255 819.321075,29.3376133 L817.716343,31.8572899 C814.815482,29.9521686 811.359136,28.7230581 808.026231,28.7230581 C803.705799,28.7230581 800.866658,31.058368 800.866658,34.1925999 L800.866658,34.3155109 C800.866658,37.8184759 805.12537,39.1090419 809.630963,40.3996079 C814.692041,41.813085 820,43.6567508 820,49.1877481 L820,49.3106592 C820,54.903112 815.185804,58.4675325 809.137199,58.4675325 Z M644.223506,27.5368478 L649.921683,21.9480519 L656.12137,28.0287315 L650.410346,33.6301281 C653.873285,39.6947521 652.97562,47.5094104 647.71735,52.6667441 C646.76394,53.601852 645.72146,54.3963545 644.616695,55.0502516 L646.554631,62.1438924 C653.64101,62.234779 660.092324,66.9045865 662.016984,73.9496353 C664.337851,82.4449639 659.197676,91.1771075 650.536082,93.453424 C641.874487,95.7297404 632.971443,90.6882349 630.650576,82.1929063 C628.719812,75.1255165 631.952703,67.8942312 638.080998,64.3523626 L636.162765,57.3308403 C632.032091,57.3125692 627.90717,55.7578705 624.755545,52.6667441 C618.414818,46.4477319 618.414818,36.364721 624.755545,30.1457088 C630.03049,24.9720204 638.031978,24.1024 644.223506,27.5368478 Z M648.15907,84.8628715 C652.119469,83.8049934 654.469746,79.7468828 653.408561,75.7988279 C652.347375,71.850773 648.276576,69.5078218 644.316177,70.5656999 C640.355778,71.6235781 638.005501,75.6816886 639.066687,79.6297435 C640.127873,83.5777984 644.198671,85.9207496 648.15907,84.8628715 Z M631.085841,46.429232 C633.985774,49.3201261 638.687494,49.3201261 641.587427,46.429232 C644.487359,43.5383379 644.487359,38.8512725 641.587427,35.9603784 C638.687494,33.0694843 633.985774,33.0694843 631.085841,35.9603784 C628.185908,38.8512725 628.185908,43.5383379 631.085841,46.429232 Z"></path>
            </g>
        </svg>
    </a>
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

        analytics("blog-composer");

        let loggedTime = (new Date()).getTime();

        this.blocked = false;
        this.warningMessages = [];

        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.editable = false;
        this.saved = false;
        this.autosave = true;
        this.published = false;
        this.timeText = '';
        this.title = '';

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
                startBlogPost('Unnamed', 'Dummy content...', function(response) {
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
                            let url = prompt('Enter the link URL');
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
                            let url = prompt('Enter the image URL');
                            if(url) pell.exec('insertImage', url);
                        }
                    }
                ],
                classes: {
                    actionbar: 'graphjs-toolbar',
                    button: 'graphjs-tool',
                    selected: 'graphjs-selected',
                    content: 'graphjs-body  graphjs-article'
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
            title.addEventListener('change', function() {
                self.title = title.value;
                self.saved = false;
                self.update();
            });
            /*
            body.addEventListener('paste', function(event) {
                event.preventDefault();
                event.stopPropagation();
                let paste = (event.clipboardData || window.clipboardData).getData('text');
                if(paste) {
                    paste = paste.replace(/<[^/].*?>/g, i => i.split(/[ >]/g)[0] + '>').trim();
                    const selection = window.getSelection();
                    if (!selection.rangeCount) return false;
                    selection.getRangeAt(0).insertNode(document.createTextNode(paste));
                }
            });
            */
            body.addEventListener('paste', function(event) {
                event.preventDefault();
                event.stopPropagation();
                let paste = (event.clipboardData || window.clipboardData).getData('text/html');
                if(paste) {
                    console.log(1, paste)
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
                    console.log(2, paste)
                    let selection = window.getSelection();
                    if (!selection.rangeCount) return false;
                    let element = document.createElement('span');
                    element.innerHTML = paste;
                    selection.getRangeAt(0).insertNode(element);
                }
            });
            !this.published && this.autosave();
        }
        this.save = (event) => {
            let link = this.refs.save;
            if(this.validateForm) {
                if(event) {
                    event.currentTarget.setAttribute('disabled', 'disabled');
                    event.currentTarget.innerHTML = 'Saving...';
                }
                editBlogPost(self.id, self.title, self.body, function(response) {
                    if(response.success) {
                        self.saved = true;
                        self.update();
                    } else {
                        if(link) {
                            link.setAttribute('disabled', 'disabled');
                            link.innerHTML = 'Couldn\'t be saved!';
                            setTimeout(function() {
                                link.removeAttribute('disabled');
                                link.innerHTML = 'Save';
                            }, 2500);
                        }
                    }
                });
            }
        }
        this.autosave = () => {
            let autosave = setInterval(function() {
                if(!self.published) {
                    if(!self.saved) self.save();
                } else {
                    clearInterval(autosave);
                }
            }, 30000);
        }
        this.publish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = 'Publishing...';
            publishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = true;
                    self.update();
                    opts.minor && self.handleCallback({
                        link: 'post',
                        id: self.id
                    });
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = 'Couldn\'t be published!';
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = 'Publish';
                        }, 2500);
                    }
                }
            });
        }
        this.unpublish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = 'Unpublishing...';
            unpublishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = false;
                    self.update();
                } else {
                    if(link) {
                        link.setAttribute('disabled', 'disabled');
                        link.innerHTML = 'Couldn\'t be unpublished!';
                        setTimeout(function() {
                            link.removeAttribute('disabled');
                            link.innerHTML = 'Unpublish';
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
            let warningMessage = 'Title is too short.';
            if(this.refs.title.value.length >= 1) {
                this.warningMessages.includes(warningMessage) && this.warningMessages.splice(this.warningMessages.indexOf(warningMessage), 1);
                return true;
            } else {
                this.warningMessages.includes(warningMessage) || this.warningMessages.push(warningMessage);
                return false;
            }
        }
        this.checkTextBody = () => {
            let warningMessage = 'Blog post cannot be empty.';
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