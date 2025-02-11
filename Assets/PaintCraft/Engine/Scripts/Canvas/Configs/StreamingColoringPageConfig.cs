﻿using UnityEngine;
using System.Collections;
using PaintCraft.Canvas.Configs;
using System.IO;

namespace PaintCraft.Canvas.Configs{

    [CreateAssetMenu(menuName = "PaintCraft/StreamingColoringPageConfig")]
    public class StreamingColoringPageConfig : AdvancedPageConfig
    {
        public Sprite Icon;
        public string OutlinePngPath;
        public string RegionPngPath;
        public string OverlayPngPath;

        Texture2D outlineTexture;
        Texture2D regionTexture;
        Texture2D overlayTexture;

        #region implemented abstract members of PageConfig
        public override Vector2 GetSize()
        {
            return new Vector2(OutlineTexture.width, OutlineTexture.height);
        }
        #endregion



        #region implemented abstract members of AdvancedPageConfig
        public override Texture2D OutlineTexture
        {
            get
            {
                if (outlineTexture == null){
                    outlineTexture = GetStreamingTexture(OutlinePngPath);
                }
                return outlineTexture;
            }
        }

        public override Texture2D RegionTexture
        {
            get
            {
                if (regionTexture == null){
                    regionTexture = GetStreamingTexture(RegionPngPath);
                }
                return regionTexture;
            }
        }

        public override Texture2D OverlayTexture
        {
            get
            {
                if (overlayTexture == null)
                {
                    overlayTexture = GetStreamingTexture(OverlayPngPath);
                }
                return overlayTexture;
            }
        }
        #endregion

        Texture2D GetStreamingTexture(string texturePath){
            string path = Path.Combine(Application.streamingAssetsPath, texturePath);
            //path = "file://"+path;
            Texture2D result = new Texture2D(1,1, TextureFormat.Alpha8, false);
            #if UNITY_5_4 || UNITY_5_4_OR_NEWER
            result.LoadImage(File.ReadAllBytes(path), true);
            #else
            result.LoadImage(File.ReadAllBytes(path));
            #endif
            return result;
        }
    }
}