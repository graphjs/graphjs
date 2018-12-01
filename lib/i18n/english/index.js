import authLogin from './tags/auth-login';
import authRegister from './tags/auth-register';
import authReset from './tags/auth-reset';
import authState from './tags/auth-state';
import comments from './tags/comments';
import feedback from './tags/feedback';
import forumComposer from './tags/forum-composer';
import forumList from './tags/forum-list';
import forumThread from './tags/forum-thread';
import groupCard from './tags/group-card';
import groupCreator from './tags/group-creator';
import groupHeader from './tags/group-header';
import groupList from './tags/group-list';
import groupMembers from './tags/group-members';
import groupSettings from './tags/group-settings';
import messagesComposer from './tags/messages-composer';
import messages from './tags/messages';
import privateContent from './tags/private-content';
import profileActivity from './tags/profile-activity';
import profileCard from './tags/profile-card';
import profileFollowers from './tags/profile-followers';
import profileFollowing from './tags/profile-following';
import profileGroups from './tags/profile-groups';
import profileHeader from './tags/profile-header';
import profileList from './tags/profile-list';
import profileSettings from './tags/profile-settings';
import startList from './tags/star-list';
import blogComposer from './tags/blog-composer';
import blogPost from './tags/blog-post';


export default {
    "auth-login" : authLogin,
    "auth-register" : authRegister,
    "auth-reset" : authReset,
    "auth-state" : authState,
    "blog-composer": blogComposer,
    "blog-post": blogPost,
    "comments" : comments,
    "feedback" : feedback,
    "forum-composer" : forumComposer,
    "forum-list" : forumList,
    "forum-thread" : forumThread,
    "group-card" : groupCard,
    "group-creator" : groupCreator,
    "group-header" : groupHeader,
    "group-list" : groupList,
    "group-members" : groupMembers,
    "group-settings" : groupSettings,
    "messages-composer" : messagesComposer,
    "messages" : messages,
    "private-content" : privateContent,
    "profile-activity" : profileActivity,
    "profile-card" : profileCard,
    "profile-followers" : profileFollowers,
    "profile-following" : profileFollowing,
    "profile-groups" : profileGroups,
    "profile-header" :profileHeader,
    "profile-list": profileList,
    "profile-settings":profileSettings,
    "star-list":startList
};