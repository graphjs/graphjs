<docs-index>
    <aside ref="menuContainer">
        <docs-menu callback={changeProperties} components={components} functions={functions}></docs-menu>
        <a onclick={toggleMenu}>
            <svg version="1.1" viewBox="106.925 6.163 41.27 32.386" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve">
                <path d="M145.248,6.163h-35.375c-1.628,0-2.948,1.319-2.948,2.948c0,1.628,1.32,2.947,2.948,2.947h35.375 c1.628,0,2.947-1.319,2.947-2.947C148.195,7.483,146.875,6.163,145.248,6.163z"></path>
                <path d="M145.248,19.408h-35.375c-1.628,0-2.948,1.319-2.948,2.948c0,1.628,1.32,2.947,2.948,2.947h35.375 c1.628,0,2.947-1.319,2.947-2.947C148.195,20.728,146.875,19.408,145.248,19.408z"></path>
                <path d="M148.195,35.601c0-1.628-1.319-2.947-2.947-2.947h-35.375c-1.628,0-2.948,1.319-2.948,2.947 c0,1.629,1.32,2.948,2.948,2.948h35.375C146.875,38.549,148.195,37.23,148.195,35.601z"></path>
            </svg>
        </a>
    </aside>
    <main ref="main">
    </main>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        docs-index {
            display: inline-block;
            width: 100%;
            aside {
                position: fixed;
                z-index: 9;
                top: 0;
                bottom: 0;
                left: 0;
                width: 200px;
                height: auto;
                background: linear-gradient(rgb(93, 60, 246), rgb(158, 119, 255));
                .transition(left .35s ease);
                & > a {
                    display: none;
                    position: absolute;
                    top: 2.5em;
                    right: -3em;
                    width: 2em;
                    height: 2em;
                    svg {
                        padding: .2em 0;
                        path {
                            fill: rgb(93, 60, 246);
                        }
                    }
                }
                .menu {
                    overflow-y: scroll;
                    display: inline-block;
                    height: 100%;
                    padding: 10%;
                    color: white;
                    img {
                        width: 85%;
                        height: auto;
                        margin: 7.5%;
                    }
                    form {
                        fieldset {
                            border: none;
                            input[type="radio"] {
                                display: inline-block;
                                width: auto;
                                margin-left: 10%;
                                &:first-of-type {
                                    margin-left: 0;
                                }
                            }
                        }
                    }
                    h2 {
                        color: white;
                        display: inline-block;
                        width: 100%;
                        margin: 1em 0;
                        padding: 0 5%;
                        font-size: 1.25em;
                        text-shadow: 0.1em 0.1em 0.1em rgba(0, 0, 0, .1);
                    }
                    a {
                        color: white;
                        font-size: 1em;
                        line-height: 175%;
                        display: inline-block;
                        width: 100%;
                        padding: 0 5%;
                        &.active {
                            color: yellow;
                        }
                        &.submenu {
                            display: none;
                            font-size: 1em;
                            line-height: 150%;
                            &::before {
                                content: "└";
                                margin-right: .25em;
                            }
                            &.visible {
                                display: block;
                            }
                        }
                    }
                }
            }
            main {
                display: inline-block;
                width: calc(100% - 200px);
                margin-left: 200px;
                padding: 2.5em 5em;
                h1 {
                    color: rgb(93, 60, 246);
                    margin: 0;
                    font-size: 2em;
                    line-height: 1em;
                }
                h2 {
                    color: rgb(158, 119, 255);
                    margin: 0;
                    margin-top: 1em;
                }
                .demo {
                    width: 100%;
                    margin-top: 5%;
                    margin-bottom: 5%;
                    & > * {
                        margin: 0;
                    }
                }
                .options {
                    max-width: 50em;
                    form {
                        width: 100%;
                        margin-bottom: 5%;
                        margin-right: 5%;
                        fieldset {
                            float: left;
                            position: relative;
                            width: 47.5%;
                            height: 5em;
                            margin: 0;
                            margin-bottom: 2.5%;
                            .no-padding;
                            border: none;
                            &:nth-child(even) {
                                margin-left: 5%;
                            }
                            legend {
                                float: left;
                                width: auto;
                                text-align: left;
                            }
                            input[type="checkbox"] {
                                display: inline-block;
                                max-width: 1.5em;
                                max-height: 1.5em;
                                margin: 0;
                            }
                            input[type="text"] {
                                position: relative;
                                margin: 0;
                                margin-top: .5em;
                            }
                            .radiobutton {
                                display: inline-block;
                                width: 100%;
                                height: 2.5em;
                                margin-top: .5em;
                            }
                            input[type="radio"] {
                                display: inline-block;
                                float: left;
                                height: inherit;
                                max-width: 1.5em;
                                margin: 0;
                                .no-padding;
                                & + label {
                                    float: left;
                                    height: inherit;
                                    line-height: 2.5em;
                                    margin-right: 2.5%;
                                }
                            }
                        }
                        .code {
                            display: block;
                            overflow: hidden;
                            width: 100%;
                            font-size: 1.2em;
                            line-height: 150%;
                            word-wrap: break-word;
                            white-space: pre-wrap;
                        }
                        button {
                            .background-color-states(rgb(158, 119, 255));
                        }
                    }
                }
            }
        }

        /* Window Width < 480 */
        @media only screen and (max-width: 479px) {
            docs-index {
                aside {
                    left: -200px;
                    & > a {
                        display: inline-block;
                    }
                    &.open {
                        left: 0;
                    }
                }
                main {
                    width: 100%;
                    margin-left: 0;
                    padding: 2.5em 1.5em 2.5em 4em;
                    .options {
                        width: 100%;
                        max-width: none;
                        form {
                            fieldset {
                                width: 100%;
                                margin-left: 0 !important;
                            }
                        }
                    }
                }
            }
        }

        /* 480 ≤ Window Width < 768 */
        @media only screen and (min-width: 480px) and (max-width: 767px) {
            docs-index {
                aside {
                    left: -200px;
                    & > a {
                        display: inline-block;
                    }
                    &.open {
                        left: 0;
                    }
                }
                main {
                    width: 100%;
                    margin-left: 0;
                    padding: 2.5em 1.5em 2.5em 4em;
                    .options {
                        width: 100%;
                        max-width: none;
                        form {
                            fieldset {
                                width: 100%;
                                margin-left: 0 !important;
                            }
                        }
                    }
                }
            }
        }

        /* 768 ≤ Window Width < 1024 */
        @media only screen and (min-width: 768px) and (max-width: 1023px) {
            docs-index {
                aside {
                    left: -200px;
                    & > a {
                        display: inline-block;
                    }
                    &.open {
                        left: 0;
                    }
                }
                main {
                    width: 100%;
                    margin-left: 0;
                    padding: 2.5em 1.5em 2.5em 4em;
                    .options {
                        width: 100%;
                        max-width: none;
                    }
                }
            }
        }

        /* 1024 ≤ Window Width < 1152 */
        @media only screen and (min-width: 1024px) and (max-width: 1151px) {
            docs-index {
                main {
                    padding: 2.5em;
                }
            }
        }

        /* 1152 ≤ Window Width < 1280 */
        @media only screen and (min-width: 1152px) and (max-width: 1280px) {
            docs-index {
                main {
                    padding: 2.5em;
                }
            }
        }

        /* 1280 ≤ Window Width < 1440 */
        @media only screen and (min-width: 1280px) and (max-width: 1439px) {

        }

        /* 1440 ≤ Window Width < 1680 */
        @media only screen and (min-width: 1440px) and (max-width: 1679px) {

        }

        /* 1680 ≤ Window Width */
        @media only screen and (min-width: 1680px) {

        }
    </style>
    <script>
        import './menu.tag';
        // Functions
        import showGroupCreator from '../scripts/showGroupCreator.js';
        this.functionsList = {
            showGroupCreator: showGroupCreator
        };
        this.functions = [
            {"label": "Create Group", "function": "showGroupCreator"}
        ];
        //Components
        this.components = [
            {"label": "State", "component": "state"},
            {"label": "Auth", "component": "auth"},
            {"label": "Register", "component": "auth-register", "parent": "auth"},
            {"label": "Login", "component": "auth-login", "parent": "auth"},
            {"label": "Reset Password", "component": "auth-reset", "parent": "auth"},
            {"label": "Comments", "component": "comments"},
            {"label": "Messages", "component": "messages"},
            {"label": "Forum", "component": "forum"},
            {"label": "List", "component": "forum-list", "parent": "forum"},
            {"label": "Thread", "component": "forum-thread", "parent": "forum"},
            {"label": "Compose", "component": "forum-compose", "parent": "forum"},
            {"label": "Star: Button", "component": "star-button"},
            {"label": "Star: List", "component": "star-list"},
            {"label": "Profile", "component": "profile"},
            {"label": "Profile: Card", "component": "profile-card"},
            {"label": "Group", "component": "group"},
            {"label": "Group: Card", "component": "group-card"},
            {"label": "List", "component": "list"},
            {"label": "Alert", "component": "alert"}
        ];
        this.activeItem = 'introduction';
        this.toggleMenu = (event) => {
            event.preventDefault();
            this.refs.menuContainer.classList.toggle('open');
            document.body.classList.toggle('push');
        }
        this.changeProperties = (event) => {
            this.refs.menuContainer.classList.toggle('open');
            document.body.classList.toggle('push');
            for(let element of event.currentTarget.parentNode.children) {
                element.classList.remove('active');
            }
            event.currentTarget.classList.add('active');
            if(!event.currentTarget.dataset.hasOwnProperty('parent')) {
                let removals = document.querySelectorAll('.submenu');
                for(let removal of removals) {
                    removal.classList.remove('visible');
                }
                let parent = event.currentTarget.dataset.component;
                let query = '.' + parent + '-item';
                for(let item of document.querySelectorAll(query)) {
                    item.classList.add('visible');
                }
            }
            this.activeItem = event.target.dataset.id;
            this.update();
            this.refs.main.innerHTML = '';
            if(event.currentTarget.dataset.type == 'component') {
                this.createTag(event.currentTarget.dataset.component, event.currentTarget.dataset.label);
            } else if(event.currentTarget.dataset.type == 'function') {
                let functionName = event.currentTarget.dataset.function;
                this.functionsList[functionName]();
            }
        }
        this.createTag = (itemComponent, itemLabel) => {
            let currentElement = document.createElement('docs-' + itemComponent);
            let component = document.createAttribute('component');
            component.value = 'graphjs-' + itemComponent;
            currentElement.setAttributeNode(component);
            let label = document.createAttribute('label');
            label.value = itemLabel;
            currentElement.setAttributeNode(label);
            riot.mount(currentElement);
            this.refs.main.appendChild(currentElement);
        }
    </script>
</docs-index>