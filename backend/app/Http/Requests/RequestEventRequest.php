<?php

namespace App\Http\Requests;
use App\Rules\PhoneRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Validation\ValidationException;
class RequestEventRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'secondName' => 'required|string|max:100',
            'firstName' => 'required|string|max:100',
            'middleName' => 'string|max:255',
            'edu' => 'required|string|max:255',
            'phone' => ['required','string','max:11',new PhoneRule],
            'countChild' => 'required|integer|min:1|max:100',
            'fromClass' => 'required|integer|min:1|max:11',
            'toClass' => 'integer|min:1|max:11',
            'idEvent' => 'required|string'
        ];
    }
    protected function failedValidation(Validator $validator)
    {
        $res = response()->json(['success' => false, 'message' => 'Validation failed'], 422, [], JSON_UNESCAPED_UNICODE);
        throw new ValidationException($validator, $res);
    }
}
