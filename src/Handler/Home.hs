{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import           Handler.Common
import           Import
import qualified Network.MPD as MPD
import           Network.MPD (Metadata(..))
import           Text.Julius (RawJS (..))
import           Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

-- Define our data that will be used for creating the form.
data FileForm = FileForm
    { fileInfo :: FileInfo
    , fileDescription :: Text
    }


-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
    (songs,mCurrent) <- withMPD $ (,) <$> MPD.playlistInfo Nothing
                                      <*> MPD.currentSong
    defaultLayout $ do
        $(widgetFile "homepage")
  where
    songWidget s = $(widgetFile "song")
    showPosition = maybe "?" show . MPD.sgIndex
    get' s t = maybe "" MPD.toText $ lookupTagOf s t






-- postHomeR :: Handler Html
-- postHomeR = do
--     ((result, formWidget), formEnctype) <- runFormPost sampleForm
--     let handlerName = "postHomeR" :: Text
--         submission = case result of
--             FormSuccess res -> Just res
--             _ -> Nothing

--     defaultLayout $ do
--         let (commentFormId, commentTextareaId, commentListId) = commentIds
--         aDomId <- newIdent
--         setTitle "Welcome To Yesod!"
--         $(widgetFile "homepage")

-- sampleForm :: Form FileForm
-- sampleForm = renderBootstrap3 BootstrapBasicForm $ FileForm
--     <$> fileAFormReq "Choose a file"
--     <*> areq textField textSettings Nothing
--     -- Add attributes like the placeholder and CSS classes.
--     where textSettings = FieldSettings
--             { fsLabel = "What's on the file?"
--             , fsTooltip = Nothing
--             , fsId = Nothing
--             , fsName = Nothing
--             , fsAttrs =
--                 [ ("class", "form-control")
--                 , ("placeholder", "File description")
--                 ]
--             }

-- commentIds :: (Text, Text, Text)
-- commentIds = ("js-commentForm", "js-createCommentTextarea", "js-commentList")