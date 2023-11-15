class TimeSlotsController < ApplicationController

    def create
        @time_slots = TimeSlot.where(student: session[:student_id])
        if @time_slots.any?
            @time_slots.destroy_all
        end

        create_time_slot

        redirect_to profile_path, notice: 'Schedule saved successfully'
    end

    def create_time_slot
        params[:selected_time_slots].each do |slot|
            if slot != "0"
                time_s = slot.match(/\d+\z/)
                time = time_s ? time_s[0].to_i : nil
                TimeSlot.create(available_time: time, student: current_student)
            end
        end
    end
end
