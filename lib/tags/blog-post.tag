<graphjs-blog-post
    class="graphjs-element graphjs-root"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <div if={notExisting} class="graphjs-nonexistent">
            <p>This post is no longer available!</p>
        </div>
        <div if={!deleted} class="graphjs-post" ref="scrollingContent">
            <h1 if={title} class="graphjs-title">{title}</h1>
            <ul if={loaded} class="graphjs-information">
                <li if={author} class="graphjs-author">
                    <a data-link="profile" data-id={author.id} onclick={handleShow}>{author.username}</a>
                </li>
                <li if={time} class="graphjs-time">
                    <time if={published && time.published}>{timeText}</time>
                    <time if={!published && time.lastEdited} class="graphjs-edited">{timeText}</time>
                </li>
                <li class="graphjs-action">
                    <a ref="edit" if={opts.minor} onclick={edit}>Edit</a>
                    <a ref="publish" if={!published} onclick={publish}>Publish</a>
                    <a ref="unpublish" if={published} class="graphjs-danger">Unpublish</a>
                    <a ref="delete" onclick={delete} class="graphjs-danger">Delete</a>
                </li>
            </ul>
            <div ref="body" if={body} class="graphjs-body graphjs-article"></div>
            <!--
            <div class="graphjs-replies">
                <div each={entry, index in entries} data-id={entry.id} class="graphjs-item">
                    <div class="graphjs-credit" if={authorsData.hasOwnProperty(entry.author)}>
                        <img data-link="profile" data-id={entry.author} onclick={handleShow} src={authorsData[entry.author].avatar ? downsizeImage(authorsData[entry.author].avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
                        <span>
                            <b data-link="profile" data-id={entry.author} onclick={handleShow}>{authorsData[entry.author].username || 'Unknown User'}</b>
                            <time data-timestamp={entry.timestamp}>{handleTime(entry.timestamp)}</time>
                            <a if={entry.author == userId} onclick={handleEdit} data-id={entry.id}>Edit</a>
                            <a if={entry.author == userId} onclick={index == 0 ? handleDestroy : handleRemove} data-id={entry.id}>Delete</a>
                        </span>
                    </div>
                    <p>{entry.content}</p>
                </div>
            </div>
            -->
        </div>
        <div class="graphjs-reply" if={entries.length > 0}>
            <div onclick={handleComposer} class="graphjs-synopsis">
                <b if={entries.length > 1}>{entries.length <= 2 ? (entries.length - 1) + ' reply' : (entries.length - 1) + ' replies'}</b>
                <a if={!composerReady}>Write a Reply</a>
                <a class={composerReady ? 'graphjs-icon' : 'graphjs-reverse graphjs-icon'}>
                    <svg viewBox="0 0 62 38" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path transform="translate(-19.000000, 0.000000)" d="M78.5,2.4 C81.1,5 81.1,9.1 78.5,11.6 L54.6,35.6 C52,38.2 47.9,38.2 45.4,35.6 L21.5,11.7 C18.9,9.1 18.9,5 21.5,2.5 C24.1,-0.1 28.2,-0.1 30.7,2.5 L50,21.7 L69.3,2.4 C71.8,-0.1 76,-0.1 78.5,2.4 Z"></path>
                    </svg>
                </a>
            </div>
            <form class={userId ? '' : 'graphjs-loading graphjs-blocked'}>
                <textarea ref="composer" placeholder="Write your reply here..."></textarea>
                <button ref="submit" onclick={handleReply}>Send Reply</button>
                <button onclick={handleClear} class="graphjs-danger">Clear</button>
                <div if={!loaded} class="graphjs-inline graphjs-loader">
                    <div class="graphjs-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <button if={!userId} onclick={handleBlock} class="graphjs-blockage">Login to write a reply</button>
            <form>
        </div>
        <div if={!loaded} class="graphjs-placeholder graphjs-loader">
            <div class="graphjs-title graphjs-line graphjs-fill"></div>
            <div class="graphjs-information graphjs-line graphjs-fill"></div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
            <div class="graphjs-text graphjs-paragraph">
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
                <div class="graphjs-line graphjs-fill"></div>
            </div>
        </div>
    </div>
    <a if={loaded} class="graphjs-promo graphjs-bottom graphjs-center graphjs-rounded graphjs-detached" href="https://graphjs.com" target="_blank">
        <svg viewBox="0 0 200 76" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <g transform="translate(-620.000000, -18.000000)">
                <path fill="white" d="M674.455446,35.7851486 C670.318365,35.8917598 667.03137,36.6380379 667.03137,41.2223178 L667.03137,57.4805195 L657.623762,57.4805195 L657.623762,27.8959229 L666.464646,27.8959229 L666.464646,31.0409521 L666.577991,31.0409521 C668.221489,28.0025341 670.828416,26.8831169 674.455446,26.8831169 L674.455446,35.7851486 Z M708.118812,57.4555529 L698.942919,57.4555529 L698.942919,54.2598279 L698.832366,54.2598279 C697.174072,57.2957666 693.194167,58.4675325 689.877579,58.4675325 C680.425304,58.4675325 674.455446,51.4369374 674.455446,42.6486936 C674.455446,34.0202361 680.646409,26.8831169 689.877579,26.8831169 C693.249443,26.8831169 697.008243,28.1081448 698.832366,31.0375594 L698.942919,31.0375594 L698.942919,27.8950965 L708.118812,27.8950965 L708.118812,57.4555529 Z M699.207921,42.1556606 C699.207921,37.9181313 696.044608,34.7792208 691.701755,34.7792208 C687.358902,34.7792208 684.356436,38.127392 684.356436,42.2602909 C684.356436,46.2885595 687.573364,49.5844156 691.75537,49.5844156 C696.098224,49.5844156 699.207921,46.3408747 699.207921,42.1556606 Z M746.732673,42.9848228 C746.732673,51.2489434 740.703414,58.5000428 731.659524,58.5000428 C727.974977,58.5000428 724.848694,57.4337046 722.336502,54.8211762 L722.336502,67.3506494 L713.069307,67.3506494 L713.069307,27.8961381 L721.778238,27.8961381 L721.778238,31.1484694 L721.945717,31.1484694 C724.346256,28.2693565 727.807497,26.8831169 731.603698,26.8831169 C741.205852,26.8831169 746.732673,34.4008008 746.732673,42.9848228 Z M736.831683,42.2079758 C736.831683,38.0750769 733.46962,34.7792208 728.910891,34.7792208 C724.352162,34.7792208 720.990099,38.0750769 720.990099,42.2079758 C720.990099,46.2885595 724.409146,49.5844156 728.910891,49.5844156 C733.412636,49.5844156 736.831683,46.2885595 736.831683,42.2079758 Z M777.425743,57.4805195 L768.152664,57.4805195 L768.152664,41.3681994 C768.152664,38.1670762 767.203019,35.1793612 763.180993,35.1793612 C759.158967,35.1793612 757.985876,37.6869077 757.985876,41.048087 L757.985876,57.4805195 L748.712871,57.4805195 L748.712871,18 L757.985876,18 L757.985876,30.5910846 L758.097599,30.5910846 C759.717582,27.8167778 762.957547,26.8564409 766.08579,26.8564409 C769.102309,26.8564409 772.509859,27.8701299 774.520872,30.1109161 C777.48153,33.3653914 777.425669,36.8866269 777.425669,40.9413829 L777.425743,57.4805195 Z M781.386139,58.4675325 L781.386139,54.5194805 L785.346535,54.5194805 L785.346535,58.4675325 L781.386139,58.4675325 Z M784.536438,67.3506494 C783.67726,67.3506494 786.268605,67.3506494 784.523089,67.3506494 L784.523089,64.7049266 C786.093872,64.7049266 783.861369,64.7049266 784.536438,64.7049266 C786.745755,64.7049266 788.280003,63.3219351 788.280003,60.4356921 L788.280003,26.8831169 L791.287129,26.8831169 L791.287129,60.2553019 C791.287129,65.065707 788.586853,67.3506494 784.536438,67.3506494 Z M788.316832,23.9220779 L788.316832,18 L791.287129,18 L791.287129,23.9220779 L788.316832,23.9220779 Z M809.137199,58.4675325 C804.569886,58.4675325 799.570528,56.6238667 796.237624,53.9198236 L798.027517,51.5230581 C801.483863,54.1656457 805.310531,55.6405783 809.322361,55.6405783 C813.581072,55.6405783 816.913977,53.3052683 816.913977,49.6793923 L816.913977,49.5564813 C816.913977,45.8691497 812.963868,44.5171282 808.581715,43.2880176 C803.458917,41.813085 797.780635,40.2766969 797.780635,34.6842441 L797.780635,34.561333 C797.780635,29.5219799 802.039347,25.8961039 808.149672,25.8961039 C811.91462,25.8961039 816.173332,27.2481255 819.321075,29.3376133 L817.716343,31.8572899 C814.815482,29.9521686 811.359136,28.7230581 808.026231,28.7230581 C803.705799,28.7230581 800.866658,31.058368 800.866658,34.1925999 L800.866658,34.3155109 C800.866658,37.8184759 805.12537,39.1090419 809.630963,40.3996079 C814.692041,41.813085 820,43.6567508 820,49.1877481 L820,49.3106592 C820,54.903112 815.185804,58.4675325 809.137199,58.4675325 Z M644.223506,27.5368478 L649.921683,21.9480519 L656.12137,28.0287315 L650.410346,33.6301281 C653.873285,39.6947521 652.97562,47.5094104 647.71735,52.6667441 C646.76394,53.601852 645.72146,54.3963545 644.616695,55.0502516 L646.554631,62.1438924 C653.64101,62.234779 660.092324,66.9045865 662.016984,73.9496353 C664.337851,82.4449639 659.197676,91.1771075 650.536082,93.453424 C641.874487,95.7297404 632.971443,90.6882349 630.650576,82.1929063 C628.719812,75.1255165 631.952703,67.8942312 638.080998,64.3523626 L636.162765,57.3308403 C632.032091,57.3125692 627.90717,55.7578705 624.755545,52.6667441 C618.414818,46.4477319 618.414818,36.364721 624.755545,30.1457088 C630.03049,24.9720204 638.031978,24.1024 644.223506,27.5368478 Z M648.15907,84.8628715 C652.119469,83.8049934 654.469746,79.7468828 653.408561,75.7988279 C652.347375,71.850773 648.276576,69.5078218 644.316177,70.5656999 C640.355778,71.6235781 638.005501,75.6816886 639.066687,79.6297435 C640.127873,83.5777984 644.198671,85.9207496 648.15907,84.8628715 Z M631.085841,46.429232 C633.985774,49.3201261 638.687494,49.3201261 641.587427,46.429232 C644.487359,43.5383379 644.487359,38.8512725 641.587427,35.9603784 C638.687494,33.0694843 633.985774,33.0694843 631.085841,35.9603784 C628.185908,38.8512725 628.185908,43.5383379 631.085841,46.429232 Z"></path>
            </g>
        </svg>
    </a>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/blog-post.less';
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getBlogPost from '../scripts/getBlogPost.js';
        import commentBlogPost from '../scripts/commentBlogPost.js';
        import publishBlogPost from '../scripts/publishBlogPost.js';
        import unpublishBlogPost from '../scripts/unpublishBlogPost.js';
        import removeBlogComment from '../scripts/removeBlogComment.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';
        import showBlogList from '../scripts/showBlogList.js';

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.id = opts.id;
        this.entries = [];
        this.authorsData = {};
        this.composerReady = true;
        this.body = '';
        this.rendered = false;
        
        let self = this;

        this.on('before-mount', function() {
            this.handleUser();
            this.frequentlyUpdateTime = setInterval(this.handleTimeUpdate,  60 * 1000);
        });
        this.on('mount', function() {
            this.loaded && !this.rendered && this.handleRender();
        });
        this.on('unmount', function() {
            clearInterval(this.frequentlyUpdateTime);
        });

        this.restart = () => {
            this.blocked = false;
            this.update();
            this.handleUser(function() {
                self.loaded && self.handleRender();
            });
        }
        this.handleUser = (callback) => {
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                }
                self.handleContent();
                callback && callback();
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateBlogPost'
            });
        }
        this.handleContent = () => {
            self.id && getBlogPost(self.id, function(response) {
                if(response.success) {
                    self.title = response.blog.title;
                    self.body = response.blog.summary;
                    self.author = response.blog.author;
                    self.time = {
                        started: response.blog.start_time,
                        lastEdited: response.blog.last_edit, 
                        published: response.blog.publish_time
                    };
                    self.published = !response.blog.is_draft;
                    self.loaded = true;
                    self.update();
                    self.handleRender();
                    let time = response.blog.is_draft ? response.blog.last_edit : response.blog.publish_time;
                    self.printTime(time * 1000);
                    // getBlogComments
                    /*
                    for(let entry of self.entries) {
                        getProfile(entry.author, function(response) {
                            if(response.success) {
                                self.currentAuthor = self.currentAuthor || response.profile.username;
                                self.authorsData[entry.author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.update();
                    */
                } else {
                    self.notExisting = true;
                    self.update();
                }
            });
        }
        this.handleRender = () => {
            if(this.body && !this.rendered) {
                this.refs.body.innerHTML = this.body;
            }
            this.rendered = true;
        }
        this.edit = () => {
            this.handleCallback({
                link: 'composer',
                id: self.id
            });
        }
        this.publish = (event) => {
            let link = event.currentTarget;
            link.setAttribute('disabled', 'disabled');
            link.innerHTML = 'Publishing...';
            publishBlogPost(self.id, function(response) {
                if(response.success) {
                    self.published = true;
                    self.update();
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
        this.delete = (event) => {
            let link = event.currentTarget;
            if (window.confirm('Are you sure to delete this blog post?')) {
                link.setAttribute('disabled', 'disabled');
                link.innerHTML = 'Deleting...';
                removeBlogPost(self.id, function(response) {
                    if(response.success) {
                        self.notExisting = true;
                        self.update();
                        opts.minor && self.handleCallback({
                            link: 'list'
                        });
                    } else {
                        if(link) {
                            link.setAttribute('disabled', 'disabled');
                            link.innerHTML = 'Couldn\'t be deleted!';
                            setTimeout(function() {
                                link.removeAttribute('disabled');
                                link.innerHTML = 'Delete';
                            }, 2500);
                        }
                    }
                });
            }
        }
        this.handleComposer = () => {
            this.root.classList.toggle('graphjs-composer');
            if(this.composerReady) {
                this.composerReady = false;
                this.refs.composer.value = '';
            } else {
                this.composerReady = true;
                this.refs.composer.focus();
            }
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.composer.value = '';
            this.refs.composer.focus();
        }
        this.handleReply = (event) => {
            event.preventDefault();
            self.refs.submit.classList.add('graphjs-loading');
            commentBlogPost(self.id, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.composerReady = false;
                    self.refs.composer.value = '';
                    self.root.classList.toggle('graphjs-composer');
                    self.update();
                } else {
                    self.refs.submit.classList.remove('graphjs-loading');
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
                case 'list':
                    showBlogPost({
                        scroll: true
                    });
                    break;
            }
        }
        this.handleEdit = (event) => {
            event.preventDefault();
            let textBox = event.target.parentNode.parentNode.nextElementSibling;
            let currentText = textBox.innerText;
            if(textBox.hasAttribute('contenteditable')) {
                textBox.removeAttribute('contenteditable');
                textBox.classList.remove('graphjs-editable');
                event.target.innerText = 'Edit';
                if(textBox.innerText != '') {
                    editBlogComment(event.target.dataset.id, textBox.innerText, function(response) {
                        if(response.success) {
                            self.handleContent();
                        } else {
                            //Handle error
                        }
                    });
                }
            } else {
                textBox.contentEditable = true;
                textBox.focus();
                event.target.innerText = 'Save';
                textBox.classList.add('graphjs-editable');
            }
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            if (window.confirm('Are you sure to delete this reply?')) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeBlogComment(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
        }
        this.handleDestroy = (event) => {
            event.preventDefault();
            if (window.confirm('Are you sure to remove this post?')) {
                let query = '[data-link="list"]';
                let element = document.querySelectorAll(query)[0];
                removeBlogPost(event.target.dataset.id, function(response) {
                    if(response.success) {
                        element.click();
                    } else {
                        //Handle error
                    }
                });
            }
        }
        this.handleShow = (event) => {
            let dataset = event.target.dataset;
            switch(dataset.link) {
                case 'profile':
                    showProfile({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleTimeUpdate = () => {
            let items = document.querySelectorAll('graphjs-comments time');
            for(let item of items) {
                if(item.dataset.hasOwnProperty('timestamp')) {
                    let timestamp = item.dataset.timestamp;
                    item.innerHTML = this.handleTime(timestamp);
                }
            }
        }
        this.handleTime = (timestamp) => {
            let text;
            let time = Math.floor((Date.now() - (parseInt(timestamp) * 1000)) / 1000);
            let amount;
            if(time < 1) {
                amount = time;
                text = 'Now';
            } else if(1 <= time && time < 60) {
                amount = time;
                text = amount == 1 ? amount + ' second ago' : amount + ' seconds ago';
            } else if(60 <= time && time < 60 * 60) {
                amount = Math.floor(time / 60);
                text = amount == 1 ? amount + ' minute ago' : amount + ' minutes ago';
            } else if(60 * 60 <= time && time < 60 * 60 * 24) {
                amount = Math.floor(time / 60 / 60);
                text = amount == 1 ? amount + ' hour ago' : amount + ' hours ago';
            } else if(60 * 60 * 24 <= time && time < 60 * 60 * 24 * 7) {
                amount = Math.floor(time / 60 / 60 / 24);
                text = amount == 1 ? amount + ' day ago' : amount + ' days ago';
            } else if(60 * 60 * 24 * 7 <= time && time < 60 * 60 * 24 * 30) {
                amount = Math.floor(time / 60 / 60 / 24 / 7);
                text = amount == 1 ? amount + ' week ago' : amount + ' weeks ago';
            } else if(60 * 60 * 24 * 30 <= time && time < 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30);
                text = amount == 1 ? amount + ' month ago' : amount + ' months ago';
            } else if(time >= 60 * 60 * 24 * 30 * 12) {
                amount = Math.floor(time / 60 / 60 / 24 / 30 / 12);
                text = amount == 1 ? amount + ' year ago' : amount + ' years ago';
            } else {
                //Handle errors
            }
            return text;
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
</graphjs-blog-post>