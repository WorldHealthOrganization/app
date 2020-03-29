package com.who.covid19.intro.adapter;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.viewpager.widget.PagerAdapter;


import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.FadeInBitmapDisplayer;
import com.nostra13.universalimageloader.core.listener.SimpleImageLoadingListener;
import com.who.covid19.R;
import com.who.covid19.intro.model.Content;
import com.who.covid19.intro.model.Slider;

public class ContentViewPaperAdapter extends PagerAdapter {
    private LayoutInflater layoutInflater;
    private Activity activity;
    private Context context;
    private Content content;

    private DisplayImageOptions options;


    public ContentViewPaperAdapter(Activity activity, Context context, Content content) {
        this.activity = activity;
        this.context = context;
        this.content = content;

        this.options = new DisplayImageOptions.Builder()
                .resetViewBeforeLoading(true)
                .cacheOnDisk(true)
                .imageScaleType(ImageScaleType.EXACTLY_STRETCHED)
                .bitmapConfig(Bitmap.Config.RGB_565)
                .considerExifParams(true)
                .displayer(new FadeInBitmapDisplayer(300))
                .build();
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        Slider slider = content.getSlider().get(position);
        layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = layoutInflater.inflate(R.layout.view_introduction, container, false);

        TextView title = view.findViewById(R.id.view_title);
        title.setText(slider.getTitle());

        TextView description = view.findViewById(R.id.view_description);
        description.setText(slider.getDescription());

        ImageView img = view.findViewById(R.id.view_img);
        ProgressBar view_loader = view.findViewById(R.id.view_loader);
        loadImage(slider.getImg(), img, view_loader);

        container.addView(view);

        return view;
    }

    @Override
    public int getCount() {
        return content.getSlider().size();
    }

    @Override
    public boolean isViewFromObject(View view, Object obj) {
        return view == obj;
    }


    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        View view = (View) object;
        container.removeView(view);
    }

    public void loadImage(String url, ImageView img, final ProgressBar view_loader) {
        ImageLoader.getInstance().displayImage(
                url.contains("http") ? url : "drawable://" + context.getResources().getIdentifier(url.substring(0, url.lastIndexOf(".")), "drawable", context.getPackageName()),
                img, options, new SimpleImageLoadingListener() {
            @Override
            public void onLoadingStarted(String imageUri, View view) {
                view_loader.setVisibility(View.VISIBLE);
            }

            @Override
            public void onLoadingFailed(String imageUri, View view, FailReason failReason) {
                String message = null;
                switch (failReason.getType()) {
                    case IO_ERROR:
                        message = "Input/Output error";
                        break;
                    case DECODING_ERROR:
                        message = "Image can't be decoded";
                        break;
                    case NETWORK_DENIED:
                        message = "Downloads are denied";
                        break;
                    case OUT_OF_MEMORY:
                        message = "Out Of Memory error";
                        break;
                    case UNKNOWN:
                        message = "Unknown error";
                        break;

                }
                view_loader.setVisibility(View.GONE);

            }

            @Override
            public void onLoadingComplete(String imageUri, View view, Bitmap loadedImage) {
                view_loader.setVisibility(View.GONE);
            }
        });
    }
}