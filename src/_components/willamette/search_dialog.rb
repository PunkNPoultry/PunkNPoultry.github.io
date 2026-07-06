class Willamette::SearchDialog < Bridgetown::Component
  def template
    html -> { <<~HTML
      <wll-search-dialog slot="footer">
        <wa-dialog id="search-dialog" label="#{text->{t "labels.search" }}" without-header light-dismiss>
          <wll-dialog-inner>
          </wll-dialog-inner>

          <wa-button slot="footer" size="s" appearance="outlined" variant="brand" pill data-dialog="close">
            <wa-icon name="circle-xmark" slot="start"></wa-icon>
            #{text->{t "labels.close" }}
          </wa-button>
        </wa-dialog>
      </wll-search-dialog>
    HTML
    }
  end
end
