<graphjs-feedback
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <div class="graphjs-header" if={opts.title}>
        <div class="graphjs-title">{opts.title || 'Feedback'}</div>
    </div>
    <div class="graphjs-content" ref="scrollingContent">
        <div class="graphjs-synopsis" if={feedbacks.length <= 0}>
            {i18n.noFeedbackMessageText}
        </div>
        <div each={feedback in feedbacks} data-id={feedback} class="graphjs-item" if={feedbacks}>
            <img class="graphjs-author" data-link="profile" data-id={feedbacksData[feedback].author} onclick={handleShow} src={authorsData[feedbacksData[feedback].author].avatar ? downsizeImage(authorsData[feedbacksData[feedback].author].avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} if={authorsData.hasOwnProperty(feedbacksData[feedback].author)} />
            <div class="graphjs-memo">
                <span class="graphjs-rating">
                     <svg each={item, index in Array(5)} viewBox="0 -4 80 80">
                         <path fill={index < feedbacksData[feedback].rating ? 'rgb(239, 191, 23)' : 'rgb(175, 175, 175)'} d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                     </svg>
                </span>
                <p>{feedbacksData[feedback].content}</p>
                <b if={authorsData.length > 0}>{authorsData[feedbacksData[feedback].author].username}</b>
            </div>
        </div>
        <div class={'graphjs-item graphjs-feedback'}>
            <img class="graphjs-author" src={profile ? downsizeImage(profile.avatar, 50) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/avatars/user.png'} />
            <div class={'graphjs-memo' + (blocked ? ' graphjs-loading graphjs-blocked' : '')}>
                <fieldset class="rating">
                	<input id="rate-5" type="radio" name="rating" value={5}>
                	<label for="rate-5">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-4" type="radio" name="rating" value={4}>
                	<label for="rate-4">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-3" type="radio" name="rating" value={3}>
                	<label for="rate-3">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-2" type="radio" name="rating" value={2}>
                	<label for="rate-2">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                	<input id="rate-1" type="radio" name="rating" value={1}>
                	<label for="rate-1">
                		<svg viewBox="0 -4 80 80">
                			<path d="M 40.000 60.000 L 63.511 72.361 L 59.021 46.180 L 78.042 27.639 L 51.756 23.820 L 40.000 0.000 L 28.244 23.820 L 1.958 27.639 L 20.979 46.180 L 16.489 72.361 L 40.000 60.000"></path>
                		</svg>
                	</label>
                </fieldset>
                <textarea ref="composer" placeholder={i18n.feedbackInputPlaceholder}></textarea>
                <a ref="submit" onclick={handleFeedback}>{i18n.submitButtonText}</a>
                <div if={!loaded && !blocked} class="graphjs-loader">
                    <div class="graphjs-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
            </div>
        </div>
    </div>
    <graphjs-promo properties="top right"></graphjs-promo>
    <script>
        import analytics from '../scripts/analytics.js';
        import getSession from '../scripts/getSession.js';
        import getFeedback from '../scripts/getFeedback.js';
        import addFeedback from '../scripts/addFeedback.js';
        import removeFeedback from '../scripts/removeFeedback.js';
        import getProfile from '../scripts/getProfile.js';
        import showProfile from '../scripts/showProfile.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("feedback");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['feedback'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.blocked = false;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.feedbacks = [];
        this.feedbacksData = {};
        this.authorsData = {};

        this.on('before-mount', function() {
            this.handleUser();
            this.handleContent();
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
                    self.update();
                    self.handleInformation();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleInformation = () => {
            let self = this;
            self.userId && getProfile(self.userId, function(response) {
                if(response.success) {
                    self.profile = response.profile;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleContent = (callback) => {
            let self = this;
            let url = window.location.href.replace(/\/$/, "");
            //getFeedback(url, function(response) {
                /*
                #
                #
                #
                */
                let response = {
                    "success":true,
                    "feedback":[
                        {
                            "9eee25f7881b4a3a83b54fcba0091260": {
                                "content": "The Mock Turtle's heavy sobs. Lastly, she pictured to herself how she was up to the game..",
                                "rating": 3,
                                "createTime": 1524747009,
                                "author": "40ba20f42c49d289bc30af768b965a91"
                            }
                        },
                        {
                            "96112c5a5f2ba385324e7dfd50ffa4d5": {
                                "content":"Caterpillar. Alice said to the jury, in a.",
                                "rating": 1,
                                "createTime": 1524747026,
                                "author": "48b7cac56b5993b12d17c71797dc0f48"
                            }
                        },
                        {
                            "910b5c87cfd9188c5953188b64125dfd": {
                                "content": "So she began again: 'Ou est ma chatte?' which was full of soup. 'There's.",
                                "rating": 2,
                                "createTime": 1524747053,
                                "author": "48b7f95e51fa1eeb4098f57cead68d74"
                            }
                        },
                        {
                            "95e8bcc4a9f100c3b385f39b234e47be": {
                                "content": "Alice. 'That's very.",
                                "rating": 4,
                                "createTime": 1524747100,
                                "author": "4a19102be3dc61b31ee2783c3a0698c2"
                            }
                        },
                        {
                            "990997c3e253ed270075da7644ab2a12": {
                                "content": "Yo!",
                                "rating": 5,
                                "createTime": 1525116051,
                                "author": "48760696099368953dd71a90b727acba"
                            }
                        },
                        {
                            "9624104a8aeac0bdfa49d6315ee7f355": {
                                "content": "This is a test comment.",
                                "rating": 2,
                                "createTime": 1525519888,
                                "author": "48760696099368953dd71a90b727acba"
                            }
                        }
                    ]
                };
                /*
                #
                #
                #
                */
                if(response.success) {
                    self.feedbacks = [];
                    for(let feedback of response.feedback) {
                        let key = Object.keys(feedback)[0];
                        self.feedbacks.push(key);
                        self.feedbacksData[key] = feedback[key];
                        callback && callback();
                        getProfile(feedback[key].author, function(response) {
                            if(response.success) {
                                self.authorsData[feedback[key].author] = response.profile;
                            }
                            self.update();
                        });
                    }
                    self.loaded = true;
                    self.update();
                } else {
                    //Handle errors
                }
            //});
            self.update();
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateFeedback'
            });
        }
        this.handleClear = (event) => {
            event.preventDefault();
            this.refs.composer.value = '';
            this.refs.composer.focus();
        }
        this.handleFeedback = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.add('graphjs-loading');
            let url = window.location.href.replace(/\/$/, "");
            addFeedback(url, self.refs.composer.value, function(response) {
                if(response.success) {
                    self.refs.submit.classList.remove('graphjs-loading');
                    self.handleContent(function() {
                        self.refs.scrollingContent.scrollTop = self.refs.scrollingContent.scrollHeight;
                    });
                    self.refs.composer.value = '';
                    self.update();
                } else {
                    self.refs.submit.classList.remove('graphjs-loading');
                    //Handle error
                }
            });
        }
        this.handleRemove = (event) => {
            event.preventDefault();
            let self = this;
            if (window.confirm(i18n.feedbackDeleteComfirmationText)) {
                let query = '[data-id="' + event.target.dataset.id + '"]';
                let element = document.querySelectorAll(query)[0];
                element.parentNode.removeChild(element);
                self.update();
                removeFeedback(event.target.dataset.id, function(response) {
                    if(response.success) {
                        self.handleContent();
                    } else {
                        //Handle error
                    }
                });
            }
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
            }
        }
    </script>
</graphjs-feedback>