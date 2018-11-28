class RulesController < ApplicationController
    before_action :set_rule, only: [:show, :update, :delete]
    skip_before_action :verify_authenticity_token

    def index
        rules = Rule.all
        if rules.present?
            render json: rules, status: :ok
        else
            render json: {
                message: "data not found"
            }, status: :unprocessable_entity
        end
    end

    def show
        @rule = set_rule
        render json: {result: true, rule: @rule}, status: :ok
    end

    def create
        @rule = Rule.create(rule_param)
        if @rule.save
            render json: {result: true, rules:@rule}, status: :created
        else
            render json: {result: false, rules: @rule.errors}, status: :unprocessable_entity
        end
    end

    def update
        if @rule.update(rule_param)
            render json: {result: true, msg: "delete success"}
        else
            render json: {result: false, msg: "delete failed"}
        end
    end

    def delete
        if @rule.destroy
            render json: {result: true, msg: "delete success"}
        else
            render json: {result: false, msg: "delete failed"}
        end
    end

    private
    def rule_param
        params.require(:rule).permit(:desc_rules, :img_rules)
    end

    def set_rule
        @rule = Rule.find_by(id: params[:id])
    end
end
