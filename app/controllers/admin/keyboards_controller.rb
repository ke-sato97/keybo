# frozen_string_literal: true

module Admin
  class KeyboardsController < Admin::BaseController
    before_action :set_keyboard, only: %i[edit update destroy]

    def index
      @keyboards = Keyboard.all
    end

    def edit
      @tags = @keyboard.tags
    end

    def update
      if @keyboard.update(keyboard_params)
        # タグの関連付けも更新する
        @keyboard.tags.clear
        if params[:keyboard][:tag_ids].present?
          params[:keyboard][:tag_ids].each do |tag_id|
            tag = Tag.find(tag_id)
            @keyboard.tags << tag
          end
        end
        redirect_to admin_keyboards_path, success: 'キーボード情報を更新しました'
      else
        flash[:danger] = '更新に失敗しました'
        redirect_to action: 'edit'
      end
    end

    def destroy
      @keyboard.destroy
      redirect_to admin_keyboards_path, status: :see_other, success: 'キーボード情報を削除しました'
    end

    def search
      @keyboards = KeyboardSearchService.new(params[:keyword]).perform
    end

    private

    def keyboard_params
      params.require(:keyboard).permit(:name, :price, :url, :size, :switch, :layout, :caption, os: [],
                                                                                               medium_image_urls: [], connect: [])
    end

    def set_keyboard
      @keyboard = Keyboard.find(params[:id])
    end

  end
end
