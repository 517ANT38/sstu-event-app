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
            'middleName' => 'string|max:100|min:0|nullable',
            'edu' => 'required|string|max:255',
            'phone' => ['required','string','max:11',new PhoneRule],
            'countChild' => 'required|integer|min:1|max:100',
            'fromClass' => 'required|integer|min:1|max:11',
            'toClass' => 'integer|min:1|max:11|nullable',
            'idEvent' => 'required|string'
        ];
    }

    protected function withValidator(Validator $validator): void
    {
        $validator->after(function ($validator) {
            $fromClass = $this->input('fromClass');
            $toClass = $this->input('toClass');

            if (!is_null($toClass) && $fromClass >= $toClass) {
                $validator->errors()->add('fromClass', '`fromClass` should be less `toClass`.');
            }
        });
    }

    protected function failedValidation(Validator $validator)
    {
        $res = response()->json(['success' => false,
            'message' => 'Validation failed',
            'errors' => $validator->errors()],
            422, [], JSON_UNESCAPED_UNICODE);
        throw new ValidationException($validator, $res);
    }
}
