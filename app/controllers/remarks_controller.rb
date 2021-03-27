class RemarksController < ApplicationController
  def index
    render json: [
      {
        place: "HC5BBEC22F049435CB96653F6F225CFE8",
        body: <<-END,
This Table of Contents has been suppressed
because it is too long.

Please click "collapse all measures" to see
only the code's measure headings.
END
        person: {
          handle: "c4lliope",
          badges: ["programmer"],
        },
      },
    ]
  end
end
